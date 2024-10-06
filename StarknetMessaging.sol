// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StarknetMessaging {

    // Evento para mensagens enviadas
    event MessageSent(address indexed sender, uint256 indexed receiver, string message);

    // Estruturas de dados
    struct Message {
        address sender;
        uint256 receiver;
        string content;
        uint256 timestamp;
    }

    // Mapeamento de mensagens enviadas para um endereço específico
    mapping(uint256 => Message[]) public messages;

    // Função para enviar uma mensagem
    function sendMessage(uint256 _receiver, string memory _message) public {
        require(bytes(_message).length > 0, "A mensagem não pode ser vazia.");

        Message memory newMessage = Message({
            sender: msg.sender,
            receiver: _receiver,
            content: _message,
            timestamp: block.timestamp
        });

        messages[_receiver].push(newMessage);

        emit MessageSent(msg.sender, _receiver, _message);
    }

    // Função para recuperar todas as mensagens recebidas por um determinado endereço
    function getMessages(uint256 _receiver) public view returns (Message[] memory) {
        return messages[_receiver];
    }

}