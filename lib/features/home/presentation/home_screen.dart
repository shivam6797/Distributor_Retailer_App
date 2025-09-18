import 'package:distributor_retailer_app/config/app_routes.dart';
import 'package:distributor_retailer_app/core/widgets/distributor_card.dart';
import 'package:distributor_retailer_app/features/home/bloc/distributor_retailer_bloc.dart';
import 'package:distributor_retailer_app/features/home/bloc/distributor_retailer_event.dart';
import 'package:distributor_retailer_app/features/home/bloc/distributor_retailer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDistributorSelected = true;
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _scrollController.addListener(_onScroll);
  }

  void _loadInitialData() {
    context.read<DistributorRetailerBloc>().add(
      LoadDistributorRetailer(
        type: isDistributorSelected ? "Distributor" : "Retailer",
        page: 1,
        isInitialLoad: true,
      ),
    );
  }

  void _onScroll() {
    final state = context.read<DistributorRetailerBloc>().state;
    if (state is DistributorRetailerLoaded) {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        if (!state.isLoadingMore && state.hasMore!) {
          context.read<DistributorRetailerBloc>().add(
            LoadDistributorRetailer(
              type: isDistributorSelected ? "Distributor" : "Retailer",
              page: state.currentPage + 1,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "DISTRIBUTOR/RETAILER LIST",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        actions: [
          Container(
            width: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: InkWell(
              onTap: () {},
              child: Text(
                "Async",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          IntrinsicWidth(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(4),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_alt_rounded, color: Colors.black),
                splashRadius: 20,
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: size.width * 0.04,
          left: size.width * 0.04,
          bottom: size.height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "(Beta Test)",
              style: GoogleFonts.poppins(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                cursorColor: Colors.black,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: GoogleFonts.poppins(color: Colors.black54),
                  suffixIcon: const Icon(Icons.search, color: Colors.black),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                ),
                onChanged: (value) {
                  context.read<DistributorRetailerBloc>().add(
                    FilterDistributorRetailerByName(value),
                  );
                },
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDistributorSelected
                          ? Colors.black
                          : Colors.grey[200],
                      foregroundColor: isDistributorSelected
                          ? Colors.white
                          : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () {
                      setState(() => isDistributorSelected = true);
                      _loadInitialData();
                    },
                    child: Text(
                      "DISTRIBUTOR",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.02),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !isDistributorSelected
                          ? Colors.black
                          : Colors.grey[200],
                      foregroundColor: !isDistributorSelected
                          ? Colors.white
                          : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () {
                      setState(() => isDistributorSelected = false);
                      _loadInitialData();
                    },
                    child: Text(
                      "RETAILER",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Expanded(
              child:
                  BlocListener<
                    DistributorRetailerBloc,
                    DistributorRetailerState
                  >(
                    listener: (context, state) {
                      if (state is DistributorRetailerLoaded) {
                        setState(() {});
                      }
                    },
                    child:
                        BlocBuilder<
                          DistributorRetailerBloc,
                          DistributorRetailerState
                        >(
                          builder: (context, state) {
                            if (state is DistributorRetailerLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  color: Colors.black,
                                ),
                              );
                            } else if (state is DistributorRetailerLoaded) {
                              if (state.items.isEmpty) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/boy_data.png",
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      ),
                                      Text(
                                        "No data found",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return RefreshIndicator(
                                color: Colors.white,
                                backgroundColor: Colors.black,
                                onRefresh: () async {
                                  context.read<DistributorRetailerBloc>().add(
                                    LoadDistributorRetailer(
                                      type: isDistributorSelected
                                          ? "Distributor"
                                          : "Retailer",
                                      page: 1,
                                    ),
                                  );
                                },
                                child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount:
                                      state.items.length +
                                      (state.isLoadingMore ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    if (index < state.items.length) {
                                      final item = state.items[index];
                                      return DistributorCard(
                                        name: item.businessName ?? "-",
                                        address: item.address ?? "-",
                                        status: (item.isApproved == "0")
                                            ? "Active"
                                            : "Inactive",
                                        onDelete: () {},
                                        onEdit: () {
                                          context.pushNamed(
                                            AppRoutes.addDistributorRetailer,
                                            extra: {
                                              'isEdit': true,
                                              'distributorData': item.toJson(),
                                            },
                                          );
                                        },
                                        id: item.id ?? "-",
                                      );
                                    } else {
                                      return const Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.grey,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            } else if (state is DistributorRetailerError) {
                              return Center(
                                child: Text(
                                  state.message,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
