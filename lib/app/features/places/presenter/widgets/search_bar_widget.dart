import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final bool isLoading;
  const SearchBarWidget({
    Key? key,
    required TextEditingController searchController,
    required this.callback,
    required this.isLoading,
  })  : _searchController = searchController,
        super(key: key);

  final TextEditingController _searchController;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800,
              offset: const Offset(0, 5),
              blurRadius: 10,
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onEditingComplete: callback,
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            suffixIcon: isLoading
                ? Transform.scale(
                    scale: 0.5,
                    child: const CircularProgressIndicator(
                      strokeWidth: 5,
                    ),
                  )
                : IconButton(
                    onPressed: callback,
                    icon: const Icon(Icons.search),
                  ),
          ),
        ),
      ),
    );
  }
}
