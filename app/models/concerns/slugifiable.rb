module Slugifiable 
    module InstanceMethods
        def slug 
            name.split(' ').map{|word| word.downcase}.join('-')
        end
    end
    
    module ClassMethods
        def find_by_slug(slug)
            # name = slug.split('-').map{|word| "#{word[0].upcase}#{word[1..-1]}"}.join(' ')
            # name.downcase! if self == Genre
            # self.find_by_name(name)
            self.all.each do |item|
                if item.slug == slug 
                    return item
                end
            end
        end
    end
end
