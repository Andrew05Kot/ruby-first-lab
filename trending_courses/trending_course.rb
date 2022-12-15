class TrandingCourse

    def initialize(name, stusents_count, topic)
        @tr_name = name
        @tr_stusents_count = stusents_count
        @tr_topic = topic
    end

    def display_details()
        puts "Tranding Course name #@tr_name"
        puts "Tranding Course stusents count #@tr_stusents_count"
        puts "Tranding Course topic #@tr_topic"
    end

    def get_json_object()
        return {
            name: @tr_name,
            stusents_count: @tr_stusents_count,
            topic: @tr_topic
        }
    end
end
