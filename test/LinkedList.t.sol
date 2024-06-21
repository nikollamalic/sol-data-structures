// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {console2 as console} from "forge-std/console2.sol";

import "src/LinkedList.sol";

contract LinkedListTest is Test {
    using LinkedList for LinkedList.List;

    LinkedList.List linkedList;

    modifier repopulate() {
        linkedList.add(11);
        linkedList.add(22);
        linkedList.add(33);
        linkedList.add(44);
        linkedList.add(55);

        uint256 gasLeft = gasleft();
        _;
        console.log("Gas used: ", gasLeft - gasleft());
    }

    function test_getAt() public repopulate {
        uint256 data = linkedList.getAt(0);
        assertEq(data, 11);

        data = linkedList.getAt(1);
        assertEq(data, 22);

        data = linkedList.getAt(2);
        assertEq(data, 33);

        data = linkedList.getAt(3);
        assertEq(data, 44);

        data = linkedList.getAt(4);
        assertEq(data, 55);
    }

    function test_removeHead() public repopulate {
        linkedList.remove(0);

        uint256 data = linkedList.getAt(0);

        assertEq(data, 22);
        assertEq(linkedList.size, 4);
    }

    function test_removeTail() public repopulate {
        linkedList.remove(4);

        uint256 data = linkedList.getAt(linkedList.size - 1);

        assertEq(data, 44);
        assertEq(linkedList.size, 4);
    }

    function test_removeFromMiddle() public repopulate {
        linkedList.remove(2);

        uint256 data = linkedList.getAt(2);

        assertEq(data, 44);
        assertEq(linkedList.size, 4);
    }

    function test_removeAll() public repopulate {
        linkedList.remove(0);
        linkedList.remove(0);
        linkedList.remove(0);
        linkedList.remove(0);
        assertEq(linkedList.head, 4);
        linkedList.remove(0);

        assertEq(linkedList.size, 0);
        // head should be rewinded
        assertEq(linkedList.head, 0);
    }

    function test_removeAllFromBack() public repopulate {
        linkedList.remove(4);
        linkedList.remove(3);
        linkedList.remove(2);
        linkedList.remove(1);
        linkedList.remove(0);

        assertEq(linkedList.size, 0);
    }

    LinkedList.List ll;

    function test_megaSize() public {
        uint256 size = 5000;
        for (uint256 i = 0; i < size; i++) {
            ll.add(i);
        }

        for (uint256 i = 0; i < size; i++) {
            uint256 data = ll.getAt(i);
            assertEq(data, i);
        }

        for (uint256 i = 0; i < size; i++) {
            ll.remove(0);
        }

        assertEq(ll.size, 0);
    }

    function test_array() public repopulate {
        uint256[] memory array = linkedList.toArray();

        assertEq(array[0], 11);
        assertEq(array[1], 22);
        assertEq(array[2], 33);
        assertEq(array[3], 44);
        assertEq(array[4], 55);

        assertEq(array.length, 5);
    }
}
