class Tree
    require_relative "node"

    def initialize(data)
        @search_result = nil
        @tree = build_tree(data)
    end

    def breadth_first_search(target, level = @tree)
        queue = []
        Array(level).each do |node|
            @search_result = node if node.value == target
            Array(node.children).each do |child|
                queue << child if child
            end
        end
        breadth_first_search(target, queue) if queue != []
        if level == @tree
            output = @search_result.dup
            @search_result = nil
            output
        end        
    end

    private

    def build_tree(data, parent = nil)
        if data.length < 2
            return Node.new(data[0], parent) if data[0]
        else
            middle = (data.length - 1) / 2
            left = data[0...middle]
            right = data[(middle+1)..-1]
            if left[(left.length-1)/2] && right[(right.length-1)/2]
                left ,right = right, left if left[(left.length-1)/2] >= right[(right.length-1)/2]
            end
            node = Node.new(data[middle], parent)
            node.children = [build_tree(left, node), build_tree(right, node)]
            return node
        end
    end
end