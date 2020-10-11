# Chat ASAP!
[English](#english) below.</br>
Aplicativo para iniciar conversas no Whatsapp sem a necessidade prévia de adição de contatos. 

## Descrição

Aplicativo para uso próprio com o objetivo de facilitar um transtorno que algumas pessoas passam:
Ter a necessidade de adicionar alguém para conversar, e caso não queira manter o contato adicionado precisar deletar depois.

O aplicativo tem como entrada um campo de texto que só aceita números, e deve ser inserido o número completo (i.e. incluindo o código da cidade). Além disso, para facilitar, coloquei um dropdown de países com o Brasil como padrão e primeiro da lista. Desta forma, o usuário não precisa ficar digitando "55" sempre, sem impedir de ser escolhido um país de origem diferente. Por fim há um botão para formar o número composto pelo código do país e o que foi digitado, e abrir o Whatsapp.

![Print do resultado](/docs/printscreen_resize.png)

## Melhorias a serem feitas
- Melhorar o layout.
- Adicionar uma forma de sugestão de código de cidade.
- Utilizar a API do Whatsapp de maneira completa e permitir uma digitação prévia da mensagem a ser enviada.
- Salvar nas SharedPreferences/NSUserDefaults as últimas escolhas feitas (inclusive as ainda não implementadas), com a exceção talvez do número. Desta forma uma pessoa pode manter sempre como padrão o mesmo país, DDD e a mesma mensagem padrão. (Para o caso de um usuário que tem uma saudação comum.)
- Dark mode.


## Dependências utilizadas

- [country_pickers](https://pub.dev/packages/country_pickers)
- [url_launcher](https://pub.dev/packages/url_launcher)

### English
--- 
App used to open Whatsapp chats without the need of contact saving.

## Description

App for self-use with the intent of helping with the struggle of a few people: Having the need to add someone to your contact list even though it may be a one time conversation.

The input is a textfield that accepts only numbers, and must have the complete Whatsapp phone number inserted (with city-codes). To make it easier there is a dropdown to serve as a country-picker. Brazil is the default value.  After that you can press a button and a Whatsapp chat window with the desired number will be opened.

## Improvements
- Improve layout
- Add a way to suggest the city code.
- Fully use the Whatsapp API in order to allow a previous typed message.
- Save in cache last choices made in app.
- Dark mode

## Packages used

- [country_pickers](https://pub.dev/packages/country_pickers)
- [url_launcher](https://pub.dev/packages/url_launcher)
