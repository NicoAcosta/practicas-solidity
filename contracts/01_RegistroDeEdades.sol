// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract RegistroDeEdades {

    //  TIPOS DE DATOS

    //  string
    //      Para guardar texto
    //      Default / vació -> "" (string vacío)
    string public nombre = "Mi Registro";

    //  uint256
    //      El tipo de número que más vamos a usar
    //      Son enteros positivos comenzando desde el 0
    //      Default / vació -> 0
    uint256 unNumero2;

    //  address
    //      Son las direcciones de la blockchain.
    //      Puede ser una dirección de un usuario final o de otro contrato que está interactuando con el nuestro.
    //      Default / vació -> 0x0000000000000000000000000000000000000000 - equivalente a `address(0)`
    address unaAddress2;

    //  block. (contexto del bloque anterior)
    //      Podemos obtener info del bloque anterior al cuál se estaría incluyendo la transacción.

    //  block.number
    //      Número de bloque
    uint256 numeroPreDeploy = block.number;

    //  block.timestamp
    //      Fecha y horario del bloque
    uint256 fechaDeDeploy = block.timestamp;

    //  Fechas
    //      Se pueden hacer cálculos fácilmente con algunas keywords como `days` o `hours`
    uint256 dentroDeUnAnio = fechaDeDeploy + 1 days + 1 hours;

    //  msg. (contexto de la transacción
    //      Podemos acceder a info de la llamada que estamos recibiendo

    //  msg.sender
    //      Obtenemos cuál es la dirección (usuario u otro contrato) que está iniciando la llamada que recibimos.
    address direccionQueLlama = msg.sender;

    //  mapping
    //      Estructura de datos similar a un diccionario, con key-value
    //      Guarda para cierto tipo de datos (claves) determinados (valores)
    //      Se puede consultar para una clave su valor, pero no para un valor una clave.
    mapping(address => uint256) private edades;
    //  En este caso guardamos las edades de cada address
    //  Por ejemplo
    //      [0x5B38Da6a701c568545dCfcB03FcB875f56beddC4] -> 13
    //      [0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2] -> 25
    //      [0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db] -> 36

    /*
        FUNCIONES
        Visibilidad
            Public (pueden ser ejecutadas o consultadas desde fuera del contrato - usuarios u otros contratos-)
            Private (solo pueden ser ejecutadas o consultadas dentro del mismo contrato)
            Internal
            External
        Mutabilidad
            - (Escriben)
            View (Leen almacenamiento o contexto de bloque)
            Pure (Ninguno de los dos)
    */
    
    //  view por lectura de bloque (visibilidad)
    //      Esta función nos devuelve la fecha "actual" (del bloque anterior)
    //      Es view porque lee el contexto del bloque
    function fechaActual() public view returns(uint256) {
        return  block.timestamp;
    }

    //  view por lectura de almacenamiento (visibilidad)
    //      Esta función nos devuelve la edad para una address
    //      Es view porque lee almacenamiento del contrato
    function obtenerEdad(address unaAddress) public view returns(uint256) {
        return edades[unaAddress];
    }

    //  pure (visibilidad)
    //      Esta función es pure porque no lee información de almacenamiento ni bloque.
    //      Las funciones pure solo toman datos por parámetros y los transforman.
    function duplicar(uint256 unNumero) public pure returns(uint256) {
        return unNumero * 2;
    }

    //  write (visibilidad)
    //      No llevan una keyword en particular. Si no hay otra keyword de visibilidad podemos deducir que escribe almacenamiento.
    function actualizarNombre(string memory nuevoNombre) public {
        nombre = nuevoNombre;
    }

    //  Lo mismo que la función anterior.
    function asignarEdad(address unaAddress, uint256 unaEdad) public {
        edades[unaAddress] = unaEdad;
    }

    //  Uso de msg.sender
    function asignarMiEdad(uint256 unaEdad) public {
        //  En este caso nos interesa guardar la edad del usuario que está haciendo la llamada.
        //  Accedemos la address con msg.sender
        //  Nos aseguramos que cada usuario guarda su info y que no hay gente escribiendo la edad de otros usuarios
        //  (que podría pasar si recibiéramos la address por parámetro como en la función anterior)
        edades[msg.sender] = unaEdad;
    }
}