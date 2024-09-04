import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:rick_and_morty_app/domain/models/character_model.dart';

class CharacterDetails extends StatefulWidget {

  const CharacterDetails({Key? key}) : super(key: key);

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {

  @override
  void initState() {
    super.initState();
     context.read<CharacterModel>().loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CharacterModel>();

    final character = model.character;
    if (character == null) {
      return const Center(child: CircularProgressIndicator());
    }

    String? characterType = model.character?.type;
    if(characterType == '' || characterType == null){ characterType = 'unknown';}
    
    return Scaffold(
      appBar: AppBar(
        title: Text(model.character?.name ?? 'Unknown'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: model.character?.image == null
                 ? const SizedBox.shrink() :
                 Image.network(
                  model.character?.image ?? '',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ) 
                  
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                model.character?.name ?? '',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${model.character?.status} - ${model.character?.species}',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const Divider(height: 30, color: Colors.black54),
            _buildInfoRow('Gender:', model.character?.gender ?? ''),
            _buildInfoRow('Origin:', model.character?.origin.name ?? ''),
            _buildInfoRow('Location:', model.character?.location.name ?? ''),
            _buildInfoRow('Episodes:', model.firstEpisode?.name ?? ''),
            _buildInfoRow('Created at:', model.formattedDateOfCreation?? ''),
           
            _buildInfoRow('Created at:', characterType,)

          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
