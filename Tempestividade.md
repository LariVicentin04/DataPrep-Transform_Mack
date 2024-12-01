# Justificativa da Abordagem de Tempestividade

Para o fluxo de transformação de dados, foi selecionada a abordagem Batch. A escolha se baseia nos seguintes critérios:

- Volume de dados: A quantidade de dados a ser processada é grande, mas não é necessária a atualização em tempo real.
- Recursos disponíveis: A abordagem Batch é mais simples de implementar e mantém a integridade dos dados de forma eficiente.
- Requisitos do negócio: A atualização dos dados pode ser realizada em horários específicos, minimizando o impacto no desempenho do sistema durante o horário de pico.
