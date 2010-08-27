class YARD::Handlers::Perl::PackageHandler < YARD::Handlers::Perl::Base
  handles Package

  process do
    docstring = statement.comments
    x = P(statement.namespace)
    
    statement.comments = ''
    while x.is_a?(Proxy) || (P(x).parent.nil? && (x = P(x).parent).root?)
      register ModuleObject.new(x.namespace, x.name)
    end
    
    statement.comments = docstring
    $__PACKAGE__ = register ClassObject.new(P(statement.namespace), statement.classname) do |c|
      def c.relative_path(obj)
        if self.namespace.path == obj.path
          return obj.path
        else
          super(obj)
        end
      end
    end
  end
end
