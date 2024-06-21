// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

error OutOfBounds(uint256 index, uint256 size);

library LinkedList {
    struct Node {
        uint256 data;
        uint256 next;
    }

    struct List {
        mapping(uint256 => Node) nodes;
        uint256 head;
        uint256 tail;
        uint256 size;
    }

    modifier _increasesSize(List storage self) {
        _;
        self.size++;
    }

    modifier _decreasesSize(List storage self) {
        _;
        self.size--;

        if (self.size == 0) {
            // Reset head and tail pointers
            self.head = self.tail = 0;
        }
    }

    /**
     * @dev Returns the data at the specified index.
     * @param _index The index of the element to retrieve.
     * @return The data at the specified index.
     */
    function getAt(List storage self, uint256 _index) public view returns (uint256) {
        require(_index < self.size, "Index exceeds size");

        uint256 pointer = self.head;
        for (uint256 position = 0; position < _index; position++) {
            pointer = self.nodes[pointer].next;
        }
        return self.nodes[pointer].data;
    }

    /**
     * @dev Adds a new element to the list.
     * @param _data The data to add to the list.
     */
    function add(List storage self, uint256 _data) external _increasesSize(self) {
        Node memory node = Node(_data, 0);

        if (self.size == 0) {
            self.nodes[self.head] = node;
        } else {
            self.nodes[self.tail].next = self.tail + 1;
            self.nodes[++self.tail] = node;
        }
    }

    /**
     * @dev Removes an element from the list.
     * @param _index The index of the element to remove.
     */
    function remove(List storage self, uint256 _index) public _decreasesSize(self) {
        if (_index >= self.size) {
            revert OutOfBounds(_index, self.size);
        }
        if (_index == 0) {
            _removeHead(self);
        } else if (_index == self.size - 1) {
            _removeTail(self);
        } else {
            _removeFromMiddle(self, _index);
        }
    }

    function toArray(List storage self) public view returns (uint256[] memory) {
        uint256 pointer = self.head;
        uint256[] memory array = new uint256[](self.size);
        for (uint256 i = 0; i < self.size; i++) {
            array[i] = self.nodes[pointer].data;
            pointer = self.nodes[pointer].next;
        }
        return array;
    }

    function _removeHead(List storage self) private {
        uint256 next = self.nodes[self.head].next;
        delete self.nodes[self.head];
        self.head = next;
    }

    function _removeTail(List storage self) private {
        uint256 current = self.head;
        for (uint256 i = 1; i < self.size - 1; i++) {
            current = self.nodes[current].next;
        }
        delete self.nodes[self.tail];
        self.tail = current;
    }

    function _removeFromMiddle(List storage self, uint256 _index) private {
        uint256 current = self.head;
        uint256 previous = self.head;

        for (uint256 i = 0; i < _index; i++) {
            previous = current;
            current = self.nodes[current].next;
        }
        self.nodes[previous].next = self.nodes[current].next;
        delete self.nodes[current];
    }
}
