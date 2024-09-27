// SPDX-License-Identifier: MIT
pragma solidity >0.8.25;

struct UserData2 {
    address addy;
    string name;
    uint256 age;
    string email;
}

struct UserData {
    string name;
    uint256 age;
    string email;
}

error UserNotFound(address addy);

contract UserRegistry {
    // address
    // uint256
    // mappings, arrays, strings -> referencia a un lugar "random" donde se guarda la data

    // mappings
    mapping(address user => uint256) ages;
    // key: address -> value: uint
    mapping(address user => string) names;

    UserData2[] public users2;
    // []
    // push -> [{addy1, name1, age1, email1}]
    // push -> [{addy1, name1, age1, email1}, {addy2, name2, age2, email2} ...]

    mapping(address user => UserData) users;

    // add1 => {name1, age1, email1}
    // add2 => {name2, age2, email2}
    // ...

    function addUser(
        address addy,
        string memory name,
        uint256 age,
        string memory email
    ) public {
        users[addy] = UserData(name, age, email);
    }

    function getUserByAddress(
        address addy
    ) public view returns (UserData memory) {
        return users[addy];
    }

    function addUser2(
        address addy,
        string memory name,
        uint256 age,
        string memory email
    ) public {
        users2.push(UserData2(addy, name, age, email));
    }

    function getUserByIndex2(
        uint256 index
    ) public view returns (UserData2 memory) {
        return users2[index];
    }

    function getUserByAddress2(
        address userAddress
    ) public view returns (UserData2 memory) {
        for (uint256 i = 0; i < users2.length; i++) {
            UserData2 memory user = users2[i];
            if (user.addy == userAddress) return user;
        }
        revert UserNotFound(userAddress);
    }
}

// Contrato

// Ownable pero con invitación

// 1. Función "invitar" a ser owner a una address
//  Dejar pendiente el ownership para una address

// 2. Función para aceptar ser owner

// 3. Modifier onlyOwner

// 4. Modifier onlyPendingOwner
