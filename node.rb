class Node
    attr_accessor :value, :parent, :children

    def initialize(value = nil, parent = nil, children = nil)
        @value = value
        @parent = parent
        @children = children
    end
end