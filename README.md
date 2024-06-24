### Solidity Data Structures

Uses Foundry

This repository contains the implementation of the following data structures in Solidity:

- [x] Linked List

#### Linked List

Usage example:

```
contract SomeContract {
    using LinkedList for LinkedList.List;
    LinkedList.List list;

    function add(uint256 value) public {
        list.add(value);
    }

    function remove(uint256 index) public {
        list.remove(index);
    }

    function getAt(uint256 index) public view returns (bool) {
        return list.getAt(index);
    }

    function traverse() public view returns (uint256[] memory) {
        return list.traverse();
    }
}
```
