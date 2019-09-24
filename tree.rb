class Tree
    require_relative "node"

    def initialize(data)
        @tree = build_tree(data)
        @search_result = nil
    end

    def breadth_first_search(target)
        search(target, :breadth_first_traverse)
    end

    def depth_first_search(target)
        search(target, :depth_first_traverse)
    end

    def dfs_rec(target)
        search(target, :dft_rec)
    end

    private

    def search(target, method)
        proc = Proc.new { |node|
            return node if node.value == target
        }
        self.send method, proc
        return nil
    end

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
        nodes_to_visit = [@tree]
        until nodes_to_visit.empty?
            current_node = nodes_to_visit.pop
            nodes_to_visit << current_node.children.reject { |child| child.nil?} if current_node.children
            nodes_to_visit.flatten!
            nodes_to_visit
            proc.call(current_node)
        end    
    end

    def dft_rec(proc, root = @tree)
        proc.call(root)
        if root.children
            Array(root.children).reject { |child| child.nil?}.each do |child|
                dft_rec(proc, child) if child
            end
        end

    end
end