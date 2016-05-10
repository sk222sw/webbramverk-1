class ApiConstraints
    def initialize(options)
        @version = options[:version]
        @default = options[:default]
    end
   
    def matches?(req)
        @default || req.headers['Accept'].inluce?("application/vnd.bta-back.v#{@version}")
    end   
   
end