class Tree
    require_relative "node"

    @@SEARCH = Proc.new { |node|
        return node if node.value == target
    }
    
    @@COUNT = Proc.new { |node|
        count += 1
    }

    def initialize(data)
        @tree = build_tree(data)
        @search_result = nil
    end

    def breadth_first_search(target)
        breadth_first_traverse(@@SEARCH) if @tree.value
        return nil
    end

    def depth_first_search(target)
        depth_first_traverse(@@SEARCH) if @tree.value
        return nil
    end

    def dfs_rec(target, root = @tree)
        @search_result = root if root.value == target
        if root.children
            Array(root.children).each do |node|
                dfs_rec(target, node) if node
            end
        end
        if root == @tree
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

    def breadth_first_traverse(proc, level = @tree)
        nodes = Array(level).flatten
        next_level = []
        nodes.each do |node|
            if node
                proc.call(node)
                next_level << node.children if node.children
            end            
        end
        breadth_first_traverse(proc, next_level) unless next_level.empty?            
    end

    def depth_first_traverse(proc)
        stack = [@tree]
        i = 0
        until stack[i].children.empty?
            stack << stack[i].children
            stack.flatten
            i += 1
        end
        

    end
end