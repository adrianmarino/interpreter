require 'spec_helper'

module Ruml
  describe Ruby2DotTranspiler do
    describe "#compile" do
      let(:results) { subject.compile }

      subject { described_class.new(input) }

      context "when compile and empty input" do
        let(:input) { "" }

        it "returns a dot empty diagram" do
          expect(results).to eq(<<-DOT.strip_heredoc)
            digraph hierarchy {
              size="5,5"
              node[shape=record,style=filled,fillcolor=gray95]
              edge[dir=back, arrowtail=empty]

            }
          DOT
        end
      end

      context "when compile an empty class" do
        let(:input) { "class Card end" }

        it "returns empty class box" do
          expect(results).to include("\"Card\"[label = \"{Card}\"]")
        end
      end

      context "when compile an empty class with a super class" do
        let(:input) { "class Card < Vehicle end" }

        it "returns an class box" do
          expect(results).to include("\"Card\"[label = \"{Card}\"]")
        end

        it "return an inheritance association" do
          expect(results).to include("\"Vehicle\"->\"Card\"[style=filled, label=Is, fontcolor=darkblue]")
        end
      end

      context "when compile a class with attrs" do
        let(:input) do
          <<-DOC
            class Card
              attr_reader :wheels
              attr_accessor :fuel
              attr_writer :oil
            end
          DOC
        end

        it "returns class box with attrs" do
          expect(results).to include("\"Card\"[label = \"{Card|(r) wheels\\l(rw) fuel\\l(w) oil\\l}\"]")
        end
      end

      context "when compile a class with a module included" do
        let(:input) do
          <<-DOC
            class Card
              include Engine
            end
          DOC
        end

        it "returns an class box" do
          expect(results).to include("\"Card\"[label = \"{Card}\"]")
        end

        it "return an include association" do
          expect(results).to include("\"Engine\"->\"Card\"[style=dotted, label=Include, fontcolor=darkblue]")
        end
      end

      context "when compile a class with self include" do
        let(:input) do
          <<-DOC
            class Card
              include self
            end
          DOC
        end

        it "returns an class box" do
          expect(results).to include("\"Card\"[label = \"{Card}\"]")
        end

        it "return an include self association" do
          expect(results).to include("\"Card\"->\"Card\"[style=dotted, label=Include, fontcolor=darkblue]")
        end
      end

      context "when compile a class that extend from module" do
        let(:input) do
          <<-DOC
            class Card
              extend Engine
            end
          DOC
        end

        it "returns an class box" do
          expect(results).to include("\"Card\"[label = \"{Card}\"]")
        end

        it "return an extend association" do
          expect(results).to include("\"Engine\"->\"Card\"[style=dotted, label=Extend, fontcolor=darkblue]")
        end
      end

      context "when compile a class that extend from self" do
        let(:input) do
          <<-DOC
            class Card
              extend self
            end
          DOC
        end

        it "returns an class box" do
          expect(results).to include("\"Card\"[label = \"{Card}\"]")
        end

        it "return an extend self association" do
          expect(results).to include("\"Card\"->\"Card\"[style=dotted, label=Extend, fontcolor=darkblue]")
        end
      end

      context "when compile a module with a module included" do
        let(:input) do
          <<-DOC
            module Card
              include Engine
            end
          DOC
        end

        it "returns an class box" do
          expect(results).to include("\"Card\"[label = \"{[Card]}\"]")
        end

        it "return an include association" do
          expect(results).to include("\"Engine\"->\"Card\"[style=dotted, label=Include, fontcolor=darkblue]")
        end
      end

      context "when compile a module that extend from module" do
        let(:input) do
          <<-DOC
            module Card
              extend Engine
            end
          DOC
        end

        it "returns an class box" do
          expect(results).to include("\"Card\"[label = \"{[Card]}\"]")
        end

        it "return an extend association" do
          expect(results).to include("\"Engine\"->\"Card\"[style=dotted, label=Extend, fontcolor=darkblue]")
        end
      end

      context "when compile a class with a class method with params" do
        let(:input) do
          <<-DOC
            class Card
              def self.add_wheel(wheel, number)
              end
            end
          DOC
        end

        it "returns class box with a method with params" do
          expect(results).to include("\"Card\"[label = \"{Card|.add_wheel(wheel, number)\\l}\"]")
        end
      end

      context "when compile a class with a instance method with params" do
        let(:input) do
          <<-DOC
            class Card
              def add_wheel(wheel, number)
              end
            end
          DOC
        end

        it "returns class box with a method with params" do
          expect(results).to include("\"Card\"[label = \"{Card|#add_wheel(wheel, number)\\l}\"]")
        end
      end

      context "when compile a class with a instance method with default params" do
        let(:input) do
          <<-DOC
            class Card
              def add_wheel(wheel = 'normal', number = 4)
              end
            end
          DOC
        end

        it "returns class box with a method with default params" do
          expect(results).to include(
            "\"Card\"[label = \"{Card|#add_wheel(wheel = 'normal', number = 4)\\l}\"]")
        end
      end

      context "when compile a class with an instance method with keyword params" do
        let(:input) do
          <<-DOC
            class Card
              def add_wheel(wheel: 'normal', number: 4)
              end
            end
          DOC
        end

        it "returns class box with a method with keyword params" do
          expect(results).to include(
            "\"Card\"[label = \"{Card|#add_wheel(wheel: 'normal', number: 4)\\l}\"]")
        end
      end

      context "when compile a class with a composed object" do
        let(:input) do
          <<-DOC
            class Engine
            end

            class Card
              attr_reader :engine
            end
          DOC
        end

        it "returns an engine class box" do
          expect(results).to include("\"Engine\"[label = \"{Engine}\"]")
        end

        it "returns a car class box with an engine composition" do
          expect(results).to include("\"Card\"[label = \"{Card|(r) engine\\l}\"]")
        end

        it "return a composition association" do
          expect(results).to include(
            "\"Card\"->\"Engine\"[style=filled, label=\"Has one\", fontcolor=darkblue, arrowtail=odiamond]")
        end
      end
    end
  end
end
