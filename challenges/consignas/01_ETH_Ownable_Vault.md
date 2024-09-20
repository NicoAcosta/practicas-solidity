# Challenge #1

En este primer challenge se busca crear un contrato inteligente que cumpla con las siguientes funcionalidades:

-   Establecer una dirección especial como `owner` ("dueño") del contrato
-   Permitir a los usuarios depositar ETH
-   Obtener el balance de ETH que tiene el contrato
-   Enviar todo el ETH recolectado al owner del contrato

El contrato inteligente tendría una forma parecida a esta:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Challenge1 {
	// Variable owner
    ...

    // Las funciones pueden necesitar o no recibir parámetros

	// Configurar el owner
    constructor(...) {
        ...
    }

    // Función para depositar ETH
    function ...(...) public ... {
        ...
    }

    // Función para obtener el balance del contrato
    function ...(...) public view returns (...) {
        ...
    }

    // Función para enviar todo el ETH al owner
    function ...(...) public {
        ...
    }

}
```

## Bonus

1. La función que envía todo el ETH al owner solo puede ser llamada y ejecutada por el owner.

2. Emitir un evento cuando se depositen y cuando se retiren fondos.

3. Revertir la transacción cuando se intente depositar con una cantidad de 0 ETH, preferiblemente usando `revert` con errores custom.

4. Crear una interface para el contrato que contenga tanto errores como eventos.

## Expresividad

> La **_expresividad_** viene de la mano de cuán entendible es nuestro código. De cómo nombramos a las variables, funciones, métodos… Tiene que estar escrito de tal forma de que lo entiendas vos, tu colega o alguien que no sepa programación tanto hoy como dentro de unos años.
>
> Renombren los contratos, variables, funciones, etc. de modo que sean lo más expresivos posbile.

## Interfaces

La forma de usar la `interface` en solidity es la siguiente:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Solemos nombrar la interfaz con una `I` antecediendo el nombre del contrato
interface IChallenge1 {
    //  Acá definimos el contenido de la interfaz
}

//  Acá estamos diciendo que queremos que el contrato `Challenge1` cumpla con la interfaz `IChallenge1`
contract Challenge1 is IChallenge1 {

    //  todo lo anterior del contrato
}
```

## GitHub Gist

Cuando gestionamos proyectos o necesitamos tener nuesto cógido ordenado tiene sentido utilizar un repositorio en GitHub. Si tenemos que compartir rápidamente uno o dos archivos, podemos usar [GitHub Gist](https://gist.github.com/).

Los invitamos a guardar el archivo del challenge de esta forma para poder retomarlo el martes. Guarden el link!

Si aún no tienen cuenta de GitHub, en el [Challenge #0](https://ethkipu.notion.site/Challenge-0-Check-in-en-GitHub-d1ebd9b872ca40be83ff5b72de44f99b) tienen un [instructivo](https://ethkipu.notion.site/Challenge-0-Check-in-en-GitHub-d1ebd9b872ca40be83ff5b72de44f99b).

## Documentación adicional

Estos recursos les pueden dar una mano.

-   https://solidity-by-example.org/sending-ether/
-   https://solidity-by-example.org/view-and-pure-functions/
-   https://solidity-by-example.org/interface/
-   https://solidity-by-example.org/events/
-   https://solidity-by-example.org/error/

> **¡Cualquier cosa consulten!**
