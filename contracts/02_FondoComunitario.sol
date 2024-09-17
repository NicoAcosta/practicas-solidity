// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

//  Errores personalizados
//      El standard hoy en día para manejgar erorres y revertir transacciones.
error FaltaPlata(uint256 cantidadFaltante);

//  Struct
//      Son tipos de datos complejos, al que podemos agregarle atributos. No los usamos aún.
struct Transaction {
    address donante;
    uint256 monto;
}

contract FondoComunitario {

    //  Eventos
    //      Los usamos como logs para "avisar" que sucedieron ciertas cosas en nuestro contrato.
    //      Nos permiten entender rápidamente que sucedió en una transacción y acceder más fácilmente a esa info luego desde afuera de la chain.
    event Deposito(address depositante, uint256 monto);
    event Agradecimiento(address depositante);

    //  Immutable
    //      immutable -> tiene que inicializarse en el constructor y no se puede cambiar luego.
    //      Esta variable indica cuál es la cantidad mínima de ETH para que merezca un agradecimiento.
    uint256 public immutable cantidadMinimaParaAgradecimiento;
    
    //  Constant
    //      constant -> tiene que inicializarse en el código directamente y no se puede cambiar luego.
    //      (Quedó obsoleta luego de implementar la versión immutable con el constructor)
    //      uint256 public constant CANTIDAD_MINIMA_PARA_AGRADECIMIENTO = 10 ether;

    // En este mapping vamos sumando los aportes que cada usuario (address) realiza.
    mapping(address depositante => uint256 monto) contribuyentes;

    //  Constructor (opcional)
    //      - Nos permite parametrizar el deploy de un contrato
    //          En este caso nos permite deployar varios contratos, varias cuentas comunitarias y que podamos indicar una cantidad mínima distinta en cada una.
    //      - Es lo primero que se ejecuta (automáticamente) al deployar el contrato.
    constructor(uint256 unaCantidadMinima) {
        // inicializamos la variable immutable con la cantidad que recibimos por parámetro
        cantidadMinimaParaAgradecimiento = unaCantidadMinima;
    }
    
    //  payable
    //      Nos permite recibir ETH del usuario cuando llame la función.
    //      Si no decimos que es `payable` y el usuario manda ETH, revierte la transacción.
    function depositar() payable public {

        //  msg.value
        //      Nos informa cuanto ETH (en wei, menor unidad de medida) mandó el usuario en la transacción.
        //      Podría ser 0 también.
        //  uint256 cantidadDeETH = msg.value;

        //  Emitimos un evento de tipo `Deposito` con la info pertinente.
        emit Deposito(msg.sender, msg.value);
        //  Sumamos lo que contriyó una address a su registro.
        contribuyentes[msg.sender] += msg.value;
    }

    function depositoGeneroso() payable public {
        //  Implementación de require
        //      Es más simple y directo, aunque menos eficiente. Ya no se usa tanto.
        //      El formato es `require(condicion a cumplirse, mensaje de por qué revierte);`
        //      require(msg.value >= CANTIDAD_MINIMA, "Falta plata loko");

        //  Implementación de error personalizado
        //      Si el ETH que mandó no es suficiente, revierte la transacción e informa cuanto faltó.
        if (msg.value < cantidadMinimaParaAgradecimiento) revert FaltaPlata(cantidadMinimaParaAgradecimiento - msg.value);
        
        //  Repetimos el mismo comportamiento de la función `depositar`.
        //  Emite el evento Deposito y suma su contribución.
        depositar();

        //  Emitimos el evento de Agradecimiento.
        //  Si llega a esta parte del código es porque tiene la cantidad suficiente de ETH.
        emit Agradecimiento(msg.sender);
    }

    //  receive  
    //      Si mandamos ETH directamente a un contrato, revierte.
    //      Podemos recibirlos dentro de funciones sean `payable`
    //      O podemos incluir este `receive` que nos permite recibir ETH bajo cualquier contexto o transacción.
    receive() external payable { }

    //  Balance de ETH
    //      Ejemplo de como obtendríamos el balance de ETH de una address.
    //      Si tenemos un dato de tipo `address`, lo consultamos con `.balance`
    function balanceDeUnaAddress(address unaAddress) public view returns(uint256) {
        return unaAddress.balance;
    }

    //  Balance del propio contrato
    //      No sabemos a qué dirección se va a deployar nuestro contrato.
    //      Podemos acceder a la dirección del contrato desde el "código" una vez deployado con `address(this)`
    //      Esto nos devuelve un tipo address, al cual podemos consultarle el balance de ETH.
    function balanceContrato() public view returns(uint256) {
        return address(this).balance;
    }
}