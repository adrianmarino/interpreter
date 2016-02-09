module Ruml::Dot
  module Options
    extend self

    def default
      {
        diagram:      { fontsize: 30, labelloc: :t, label: 'Models', splines: true, overlap: true },
        class:        { shape: 'record', style: 'rounded, filled', fillcolor: '#FFECDD' },
        module:       { shape: 'record', style: 'filled', fillcolor: '#B3F6B3' },
        indentation:  "\s\s"
      }
    end
  end
end
