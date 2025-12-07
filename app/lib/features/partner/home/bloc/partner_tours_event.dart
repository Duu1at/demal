part of 'partner_tours_bloc.dart';

sealed class PartnerToursEvent {
  const PartnerToursEvent();
}

@immutable
final class PartnerToursFetchEvent extends PartnerToursEvent {
  const PartnerToursFetchEvent();
}

@immutable
final class PartnerToursRefreshEvent extends PartnerToursEvent {
  const PartnerToursRefreshEvent();
}

@immutable
final class PartnerToursPagingCancel extends PartnerToursEvent {
  const PartnerToursPagingCancel();
}
