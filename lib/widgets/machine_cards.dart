class MachineCard extends StatefulWidget {
  final String title;
  final String status;
  final IconData icon;
  final Color color;

  const MachineCard({
    super.key,
    required this.title,
    required this.status,
    required this.icon,
    required this.color,
  });

  @override
  State<MachineCard> createState() => _MachineCardState();
}

class _MachineCardState extends State<MachineCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuint,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1E3A).withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.color.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ]
              : null,
          border: Border.all(
            color: widget.color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              // Navigate to machine detail
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.color.withOpacity(0.2),
                        ),
                        child: Icon(
                          widget.icon,
                          color: widget.color,
                          size: 24,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(widget.status),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.status.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Last activity: 2 min ago',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white70,
                    ),
                  ),
                  const Spacer(),
                  LinearProgressIndicator(
                    value: _getStatusValue(widget.status),
                    backgroundColor: Colors.white10,
                    color: widget.color,
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'running':
        return Colors.green.withOpacity(0.7);
      case 'idle':
        return Colors.blueGrey.withOpacity(0.7);
      case 'maintenance':
        return Colors.orange.withOpacity(0.7);
      case 'error':
        return Colors.red.withOpacity(0.7);
      default:
        return Colors.grey.withOpacity(0.7);
    }
  }

  double _getStatusValue(String status) {
    switch (status.toLowerCase()) {
      case 'running':
        return 0.9;
      case 'idle':
        return 0.2;
      case 'maintenance':
        return 0.5;
      case 'error':
        return 0.1;
      default:
        return 0.0;
    }
  }
}