class IsDateTimeFormat < ActiveModel::EachValidator
    # maybe this will work one day :(
    def validate_each(record, attribute, value)
        unless value.is_a(DateTime)
            record.errors[attribute] << (options[:message] || "Wrong DateTime format")
        end
    end
end