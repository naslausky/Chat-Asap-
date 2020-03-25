# Chat ASAP!

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


## Dependências utilizadas

- [country_pickers](https://pub.dev/packages/country_pickers)
- [url_launcher](https://pub.dev/packages/url_launcher)
