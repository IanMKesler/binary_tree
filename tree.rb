class Tree
    require_relative "node"

    def initialize(data)
        @tree = build_tree(data)
    end

    private

    def build_tree(data, parent = nil)
        if data.length < 2
            return Node.new(data[0], parent) if data[0]
        else
            middle = (data.length - 1) / 2 
            left = data[0...middle]
            right = data[(middle+1)..-1]
            node = Node.new(data[middle], parent)
            node.children = [build_tree(left, node), build_tree(right, node)]
            return node
        end
    end

end