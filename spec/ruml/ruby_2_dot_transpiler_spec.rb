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

      context "when compile empty class" do
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
          expect(results).to include("\"Card\"->\"Vehicle\"[style=filled]")
        end
      end

      context "when compile class with attrs" do
        let(:input) do
          <<-DOC
            class Card
              attr_reader :wheels, :engine, :bodyshop
            end
          DOC
        end

        it "returns class box with attrs" do
          expect(results).to include("\"Card\"[label = \"{Card|:wheels\\n:engine\\n:bodyshop\\n}\"]")
        end
      end

      context "when compile class with a module included" do
        let(:input) do
          <<-DOC
            module Card
              include Engine
            end
          DOC
        end

        it "returns an class box" do
          expect(results).to include("\"Card\"[label = \"{Card}\"]")
        end

        it "return an include association" do
          expect(results).to include("\"Card\"->\"Engine\"[style=dotted, label=include, fontcolor=darkblue]")
        end
      end

      context "when compile class that extend from module" do
        let(:input) do
          <<-DOC
            module Card
              extend Engine
            end
          DOC
        end

        it "returns an class box" do
          expect(results).to include("\"Card\"[label = \"{Card}\"]")
        end

        it "return an extend association" do
          expect(results).to include("\"Card\"->\"Engine\"[style=dotted, label=extend, fontcolor=darkblue]")
        end
      end

      context "when compile class with a instance method with params" do
        let(:input) do
          <<-DOC
            class Card
              def add_wheel(wheel, number)
              end
            end
          DOC
        end

        it "returns class box with a method with params" do
          expect(results).to include("\"Card\"[label = \"{Card|#add_wheel(wheel, number)\\n}\"]")
        end
      end


      context "when compile class with a instance method with default params" do
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
            "\"Card\"[label = \"{Card|#add_wheel(wheel = 'normal', number = 4)\\n}\"]")
        end
      end

      context "when compile class with a instance method with keyword params" do
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
            "\"Card\"[label = \"{Card|#add_wheel(wheel: 'normal', number: 4)\\n}\"]")
        end
      end
    end
  end
end
