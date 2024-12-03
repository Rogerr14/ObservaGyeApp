
import 'package:flutter/material.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:provider/provider.dart';

class PageModal extends StatefulWidget {
  final String? summoner;
  const PageModal({super.key, this.summoner});

  @override
  State<PageModal> createState() => _PageModalState();
}

class _PageModalState extends State<PageModal> {
  late String summoner;
  @override
  void initState() {
    super.initState();
    summoner = widget.summoner ?? 'normal';
  }

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context);
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(children: fp.pages),
    );
  }
}