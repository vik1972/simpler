require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      template = File.read(template_path)
      ERB.new(template).result(binding)
    end

    private

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template
      @env['simpler.template']
    end

    def template_path
      default_path = [controller.name, action].join('/')
      path = template || default_path
      
      if template == "text"
        @env['simpler.template_path'] = "#{default_path}.text.erb"
        Simpler.root.join(VIEW_BASE_PATH, "#{default_path}.text.erb")
      else
        @env['simpler.template_path'] = "#{default_path}.html.erb"
        Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
      end
    end

  end
end
