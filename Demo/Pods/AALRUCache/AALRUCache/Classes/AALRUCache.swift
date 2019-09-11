//
//  AALRUCache.swift
//  AALRUCache
//
//  Created by cztv on 2019/9/5.
//

public class AALRUCache<K: Hashable, V: Equatable> {
    typealias Node = ListNode<K, V>
    private var dic = [K: Node]()
    private var head: Node?
    private var tail: Node?
    private var maxCount = 0
    public init(_ capacity: Int) {
        maxCount = capacity
    }
    
    public func get(_ key: K) -> V? {
        if let node = dic[key] {
            bringToFirst(node)
            return node.val
        }
        return nil
    }
    
    public func put(_ key: K, _ value: V) {
        if let node = dic[key] {
            node.val = value
            bringToFirst(node)
        } else {
            if dic.count == maxCount {
                dic.removeValue(forKey: tail!.key)
                tail = tail?.pre
                tail?.next = nil
            }
            let node = ListNode.init(key, value)
            node.next = head
            head?.pre = node
            head = node
            dic[key] = node
            if dic.count == 1 {
                tail = head
            }
        }
    }
    
    private func bringToFirst(_ node: Node) {
        guard dic.count > 1 else {
            return
        }
        guard node !== head else {
            return
        }
        if tail === node {
            tail = node.pre
        }
        node.pre?.next = node.next
        node.next?.pre = node.pre
        node.next = head
        head?.pre = node
        head = node
        head?.pre = nil
    }
}

public extension AALRUCache {
    subscript(_ key: K) -> V? {
        get {
            return get(key)
        }
        set {
            guard let newV = newValue else {
                remove(key)
                return
            }
            put(key, newV)
        }
    }
    
    func append(_ key: K, _ value: V) {
        put(key, value)
    }
    
    func removeAll() {
        dic.removeAll()
        head = nil
        tail = nil
    }
    
    @discardableResult
    func remove(_ key: K) -> V? {
        if let node = dic[key] {
            if head === node {
                head = node.next
                head?.pre = nil
            } else if tail === node {
                tail = node.pre
                tail?.next = nil
            } else {
                node.pre?.next = node.next
                node.next?.pre = node.pre
            }
            dic.removeValue(forKey: key)
            return node.val
        }
        return nil
    }
    
    func key(for value: V) -> K? {
        return dic.first(where: { (set) -> Bool in
            return value == set.value.val
        })?.key
    }
}
