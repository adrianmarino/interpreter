require 'spec_helper'

module Ruml
  describe Ruby2DotTranspiler do
    describe "#compile" do
      let(:results) { subject.compile }

      subject { described_class.new(input) }

      context "when compile an empty ruby class" do
        let(:input) { "class String end"}

        it "returns a do diagram with a class representation" do
          expect(results).to eq(<<-DOT.strip_heredoc)
            digraph hierarchy {
              size="5,5"
              node[shape=record,style=filled,fillcolor=gray95]
              edge[dir=back, arrowtail=empty]

              "String"[label = "{String}"]

            }
          DOT
        end
      end
    end
  end
end
