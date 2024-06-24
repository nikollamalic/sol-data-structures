### Solidity Data Structures

Uses Foundry

This repository contains the implementation of the following data structures in Solidity:

- [x] Linked List

#### Linked List

Feel free to update the node value to your liking. Currently it is uint256 but can be anything (structs too!).
In case you want to do some inner updates on struct elements remember to load `getAt` values into `storage` instead of `memory`.

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

    function getAt(uint256 index) public view returns (uint256) {
        return list.getAt(index);
    }

    function traverse() public view returns (uint256[] memory) {
        return list.traverse();
    }
}
```
