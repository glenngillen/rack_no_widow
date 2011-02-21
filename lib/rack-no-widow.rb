require 'rack-plastic'

module Rack
  class NoWidow < Plastic

    def initialize(app, options = {}) #:nodoc:
      @app = app
      @options = options
      @options[:selectors] ||= ["h1", "h2", "h3", "h4", "h5"]
      @p = ::Rack::PlasticHelper.new
    end

    def change_nokogiri_doc(doc)
      nodes = doc.search(@options[:selectors].join(", "))
      return doc unless nodes || nodes.empty?
      pattern = /(.*?)( )([\S]+\z)/
      replacement = "\\1&nbsp;\\3"
      nodes.each do |node|
        next if node.inner_html =~ /&nbsp;[\S]+\z/
        next if node.text.split(/\s/).size <= 3
        if node.text && node.text =~ pattern
          new_content = node.content.gsub(pattern, replacement)
          node.children.each do |child|
            if child.content == node.content
              this_new_content = new_content
            else
              content_size = child.content.sub(/\s\z/,"").length
              this_new_content = new_content.slice!(0...content_size)
              if child.content =~ /\s\z/ && new_content.index("&nbsp;") == 0
                this_new_content += new_content.slice!(0..5)
              end
            end
            update_text(child, this_new_content)
          end
        end
      end
      doc
    end

  end
end
