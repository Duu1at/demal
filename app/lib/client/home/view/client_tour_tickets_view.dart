import 'package:app_ui/app_ui.dart';
import 'package:bookings_repository/bookings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:app/client/home/blocs/paging/paging_bloc.dart';
import 'package:app/client/home/blocs/tickets/tickets_paging_bloc.dart';

class ClientTourTicketsView extends StatelessWidget {
  const ClientTourTicketsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketsPagingBloc(
        bookingsRepository: context.read<BookingsRepository>(),
      )..add(PagingFetchNext()),
      child: const ClientTourTicketsViewBody(),
    );
  }
}

class ClientTourTicketsViewBody extends StatelessWidget {
  const ClientTourTicketsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<TicketsPagingBloc, BlocPagingState<BookingModel, void>>(
      listener: (context, state) {
        if (state.error != null && state.pages != null && state.pages!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Something went wrong while fetching a new page.',
              ),
              action: SnackBarAction(
                label: 'Retry',
                onPressed: () => context.read<TicketsPagingBloc>().add(PagingFetchNext()),
              ),
            ),
          );
        }
      },
      child: ScaffoldWithBgImage(
        bgImageTop: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Мои билеты', style: theme.textTheme.titleLarge),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<TicketsPagingBloc>().add(PagingRefresh());
          },
          child: BlocBuilder<TicketsPagingBloc, BlocPagingState<BookingModel, void>>(
            builder: (context, state) {
              return PagedListView<int, BookingModel>.separated(
                state: state,
                fetchNextPage: () {
                  context.read<TicketsPagingBloc>().add(PagingFetchNext());
                },
                itemExtent: 48,
                builderDelegate: PagedChildBuilderDelegate(
                  animateTransitions: true,
                  itemBuilder: (context, item, index) => Container(),
                  firstPageErrorIndicatorBuilder: (context) => const Placeholder(),
                  newPageErrorIndicatorBuilder: (context) => const Placeholder(),
                ),
                separatorBuilder: (context, index) => const Divider(),
              );
            },
          ),
        ),
      ),
    );
  }
}




// AppCard(
//                     child: Row(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Поход в Ала-Арчу',
//                               style: theme.textTheme.titleLarge?.copyWith(
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             const SizedBox(height: AppSpacing.xs),
//                             RichText(
//                               text: TextSpan(
//                                 text: 'Дата и время: ',
//                                 style: theme.textTheme.bodyMedium?.copyWith(),
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                     text: '20 октября 2025, 08:00',
//                                     style: theme.textTheme.bodyMedium,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: AppSpacing.xs),
//                             RichText(
//                               text: TextSpan(
//                                 text: 'Организатор: ',
//                                 style: theme.textTheme.bodyMedium,
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                     text: 'Эмиль Асанов',
//                                     style: theme.textTheme.bodyMedium,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: AppSpacing.xs),
//                             RichText(
//                               text: TextSpan(
//                                 text: 'Телефон: ',
//                                 style: theme.textTheme.bodyMedium,
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                     text: '+996 555 123 456',
//                                     style: theme.textTheme.bodyMedium,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: AppSpacing.xs),
//                             RichText(
//                               text: TextSpan(
//                                 text: 'Количество мест: ',
//                                 style: theme.textTheme.bodyMedium,
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                     text: '2',
//                                     style: theme.textTheme.bodyMedium,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: AppSpacing.xs),
//                             RichText(
//                               text: TextSpan(
//                                 text: 'Место сбора: ',
//                                 style: theme.textTheme.bodyMedium,
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                     text: '2г. Бишкек, ул. Ахунбаева 112',
//                                     style: theme.textTheme.bodyMedium,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: AppSpacing.xs),
//                             RichText(
//                               text: TextSpan(
//                                 text: 'Статус: ',
//                                 style: theme.textTheme.bodyMedium,
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                     text: '"Подтверждено"',
//                                     style: theme.textTheme.bodyMedium,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: AppSpacing.md),
//                             Text(
//                               'Итоговая сумма: 2400 сом',
//                               style: theme.textTheme.titleLarge?.copyWith(
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),


// class ListViewScreen extends StatefulWidget {
//   const ListViewScreen({super.key});

//   @override
//   State<ListViewScreen> createState() => _ListViewScreenState();
// }

// class _ListViewScreenState extends State<ListViewScreen> {
//   String? _searchTerm;

//   /// This example uses a [PagingController] to manage the paging state.
//   ///
//   /// This is a robust inbuilt way to store your pagination state.
//   /// The controller can also be used in multiple Paged layouts simultaneously,
//   /// to share their state.
//   late final _pagingController = PagingController<int, Photo>(
//     getNextPageKey: (state) {
//       // This convenience getter checks if the last returned page is empty.
//       // You can replace this with a check if the last page has returned less items than expected,
//       // for a more efficient implementation.
//       if (state.lastPageIsEmpty) return null;
//       // This convenience getter increments the page key by 1, assuming keys start at 1.
//       return state.nextIntPageKey;
//     },
//     fetchPage: (pageKey) => RemoteApi.getPhotos(pageKey, search: _searchTerm),
//   );

//   @override
//   void initState() {
//     super.initState();
//     _pagingController.addListener(_showError);
//   }

//   /// This method listens to notifications from the [_pagingController] and
//   /// shows a [SnackBar] when an error occurs.
//   Future<void> _showError() async {
//     if (_pagingController.value.status == PagingStatus.subsequentPageError) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text(
//             'Something went wrong while fetching a new page.',
//           ),
//           action: SnackBarAction(
//             label: 'Retry',
//             onPressed: () => _pagingController.fetchNextPage(),
//           ),
//         ),
//       );
//     }
//   }

//   /// When the search term changes, the controller is refreshed.
//   /// The refresh will remove all existing items and fetch the first page again.
//   void _updateSearchTerm(String searchTerm) {
//     setState(() => _searchTerm = searchTerm);
//     _pagingController.refresh();
//   }

//   /// The controller needs to be disposed when the widget is removed.
//   @override
//   void dispose() {
//     _pagingController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: SearchAppBar(
//           searchTerm: _searchTerm,
//           onSearch: _updateSearchTerm,
//         ),
//         body: RefreshIndicator(
//           onRefresh: () async => _pagingController.refresh(),

//           /// The [PagingListener] is a widget that listens to the controller and
//           /// rebuilds the UI based on the state of the controller.
//           /// Its the easiest way to bind your controller to a Paged layout.
//           child: PagingListener(
//             controller: _pagingController,
//             builder: (context, state, fetchNextPage) =>

//                 /// Paged layouts rely on a [PagingState] and a [fetchNextPage] function.
//                 PagedListView<int, Photo>.separated(
//               state: state,
//               fetchNextPage: fetchNextPage,
//               itemExtent: 48,
//               builderDelegate: PagedChildBuilderDelegate(
//                 animateTransitions: true,
//                 itemBuilder: (context, item, index) => ImageListTile(
//                   key: ValueKey(item.id),
//                   item: item,
//                 ),
//                 firstPageErrorIndicatorBuilder: (context) =>
//                     CustomFirstPageError(pagingController: _pagingController),
//                 newPageErrorIndicatorBuilder: (context) =>
//                     CustomNewPageError(pagingController: _pagingController),
//               ),
//               separatorBuilder: (context, index) => const Divider(),
//             ),
//           ),
//         ),
//       );
// }
