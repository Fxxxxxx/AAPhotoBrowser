//
//  ListNode.swift
//  AALRUCache
//
//  Created by cztv on 2019/9/5.
//

public class ListNode<K, V> {
    public var key: K
    public var val: V
    public var next: ListNode?
    public var pre: ListNode?
    public init(_ key: K, _ val: V) {
        self.key = key
        self.val = val
    }
}
