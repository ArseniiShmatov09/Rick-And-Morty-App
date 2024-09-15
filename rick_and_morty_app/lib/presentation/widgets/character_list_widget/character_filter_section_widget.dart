import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/presentation/app_colors/app_colors.dart';

class CharacterFilterSectionWidget extends StatelessWidget {
  final String selectedStatus;
  final String selectedSpecies;
  final void Function(String?) onStatusChanged;
  final void Function(String?) onSpeciesChanged;
  final bool isOffline;
  final VoidCallback onSearchPressed;

  const CharacterFilterSectionWidget({
    super.key,
    required this.selectedStatus,
    required this.selectedSpecies,
    required this.onStatusChanged,
    required this.onSpeciesChanged,
    required this.isOffline,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (isOffline) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    labelText: "Status",
                  ),
                  value: selectedStatus.isEmpty ? null : selectedStatus,
                  onChanged: onStatusChanged,
                  items: <String>['All', 'Alive', 'Dead', 'unknown']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    labelText: "Species",
                  ),
                  value: selectedSpecies.isEmpty ? null : selectedSpecies,
                  onChanged: onSpeciesChanged,
                  items: <String>['All', 'Alien', 'Human', 'Humanoid']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSearchPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: AppColors.mainGrey,
                foregroundColor: AppColors.mainLightGray,
              ),
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.mainWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
