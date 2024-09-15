import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Lista para armazenar os dados obtidos da API
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    // Busca os dados da API quando o widget é carregado
    fetchData();
  }

  // Função para buscar os dados da API
  Future<void> fetchData() async {
    try {
      // Faz uma requisição GET para obter os dados dos usuários
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      
      // Verifica se a requisição foi bem-sucedida (código 200)
      if (response.statusCode == 200) {
        // Decodifica a resposta JSON e atualiza a lista 'data'
        setState(() {
          data = json.decode(response.body);
        });
      } else {
        // Se a resposta não for bem-sucedida, lança um erro
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Exibe uma mensagem de erro no console se algo der errado
      print('Erro ao buscar os dados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LISTVIEW CUSTOMIZADO',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('LISTVIEW CUSTOMIZADO'),
        ),
        body: data.isEmpty 
          // Exibe um indicador de progresso enquanto os dados estão sendo carregados
          ? const Center(child: CircularProgressIndicator())
          // Exibe a lista de itens obtidos
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                // Obtém o item atual da lista de dados
                final item = data[index];
                
                // Alterna as cores de fundo para facilitar a leitura
                final backgroundColor = index % 2 == 0 ? Colors.red[100] : Colors.white;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Exibe o ID do usuário
                          Text(
                            'ID: ${item['id']}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          
                          // Exibe o nome do usuário
                          Text(
                            'Name: ${item['name']}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          
                          // Exibe o email do usuário
                          Text(
                            'Email: ${item['email']}',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          
                          // Exibe o telefone do usuário
                          Text(
                            'Phone: ${item['phone']}',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),

                          // Exibe o endereço completo do usuário
                          Text(
                            'Address: ${item['address']['street']}, ${item['address']['suite']}, ${item['address']['city']} - ${item['address']['zipcode']}',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          
                          // Exibe a latitude e longitude do endereço
                          Text(
                            'Geo: Lat ${item['address']['geo']['lat']}, Lng ${item['address']['geo']['lng']}',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      ),
    );
  }
}
