class MachineDashboard extends StatefulWidget {
  const MachineDashboard({super.key});

  @override
  State<MachineDashboard> createState() => _MachineDashboardState();
}

class _MachineDashboardState extends State<MachineDashboard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late RiveAnimationController _riveController;
  late RiveAnimation _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _riveController = SimpleAnimation('idle');
    _backgroundAnimation = RiveAnimation.asset(
      'assets/industrial_background.riv',
      controllers: [_riveController],
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _riveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: _backgroundAnimation,
            ),
          ),
          
          // Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(),
                  const SizedBox(height: 20),
                  _buildStatusOverview(),
                  const SizedBox(height: 30),
                  _buildMachineGrid(),
                  const SizedBox(height: 30),
                  _buildPerformanceMetrics(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.menu, size: 28),
          onPressed: () {},
        ),
        Column(
          children: [
            Text(
              'INDUSTRIAL COMMAND',
              style: GoogleFonts.orbitron(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
                color: Colors.cyanAccent,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'CONTROL CENTER',
              style: GoogleFonts.orbitron(
                fontSize: 12,
                letterSpacing: 3,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        const CircleAvatar(
          backgroundColor: Colors.cyan,
          child: Icon(Icons.person, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildStatusOverview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1E3A).withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusIndicator('Production', '92%', Colors.green),
              _buildStatusIndicator('Efficiency', '88%', Colors.blue),
              _buildStatusIndicator('Quality', '95%', Colors.amber),
              _buildStatusIndicator('Uptime', '99.7%', Colors.purple),
            ],
          ),
          const SizedBox(height: 15),
          LinearProgressIndicator(
            value: 0.92,
            backgroundColor: Colors.white10,
            color: Colors.cyan,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(String title, String value, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.2),
            border: Border.all(color: color, width: 2),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildMachineGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: const [
        MachineCard(
          title: 'CNC Mill',
          status: 'Running',
          icon: Icons.precision_manufacturing,
          color: Colors.blue,
        ),
        MachineCard(
          title: '3D Printer',
          status: 'Idle',
          icon: Icons.print,
          color: Colors.purple,
        ),
        MachineCard(
          title: 'Robotic Arm',
          status: 'Maintenance',
          icon: Icons.extension,
          color: Colors.amber,
        ),
        MachineCard(
          title: 'Conveyor',
          status: 'Running',
          icon: Icons.conveyor_belt,
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _buildPerformanceMetrics() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1E3A).withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PERFORMANCE METRICS',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetricChart('Output', 85, Colors.cyan),
              _buildMetricChart('Quality', 92, Colors.green),
              _buildMetricChart('Speed', 78, Colors.amber),
              _buildMetricChart('Uptime', 97, Colors.purple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricChart(String title, int value, Color color) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          width: 60,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 20,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutQuart,
                width: 20,
                height: 80 * (value / 100),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$value%',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF0F1328),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.dashboard, 'Dashboard', true),
          _buildNavItem(Icons.analytics, 'Analytics', false),
          _buildNavItem(Icons.settings_remote, 'Control', false),
          _buildNavItem(Icons.notifications, 'Alerts', false),
          _buildNavItem(Icons.settings, 'Settings', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? Colors.cyan : Colors.white54,
          size: 28,
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.cyan : Colors.white54,
          ),
        ),
      ],
    );
  }
}