import 'package:flutter/material.dart';

import '../data/plan_repository.dart';

class PlansView extends StatelessWidget {
  const PlansView({required this.planRepository, super.key});

  final PlanRepository planRepository;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          children: [
            _buildPlanCard(
              'Santorini Trip for 5',
              [
                'Flights and Accommodation',
                'Transportation in Santorini',
                'Activities for all ages',
                '50th Birthday Celebration',
                'Toddler-Specific Needs',
                'Itinerary and Bookings',
                'Emergency Contacts and Insurance',
              ],
            ),
            _buildPlanCard(
              'Superhero Kids Room',
              [
                'Clear the clutter',
                'Organize books and toys',
                'Superhero theme decorations',
                'Install superhero bedding',
                'Set up play area',
                'Add storage solutions',
              ],
            ),
          ],
        ),
      );

  Widget _buildPlanCard(String title, List<String> todos) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {},
                    color: Colors.red[100],
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            todos[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
