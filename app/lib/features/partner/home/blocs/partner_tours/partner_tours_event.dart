part of 'partner_tours_bloc.dart';

sealed class PartnerToursEvent {
  const PartnerToursEvent();
}

final class PartnerToursFetchEvent extends PartnerToursEvent {
  const PartnerToursFetchEvent();
}

final class PartnerToursRefreshEvent extends PartnerToursEvent {
  const PartnerToursRefreshEvent();
}
