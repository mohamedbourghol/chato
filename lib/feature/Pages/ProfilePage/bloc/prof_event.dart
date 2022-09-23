// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:chato/feature/Pages/ProfilePage/model/country/country_data_model.dart';
import 'package:chato/feature/Pages/ProfilePage/model/country/country_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class ProfEvent extends Equatable {
  @override
  List<Object> get props => [];
}




class LogoutEvent extends ProfEvent {
}
// ignore: must_be_immutable
class DeleteStatusEvent extends ProfEvent{
  int statusId;

  DeleteStatusEvent({ required this.statusId,

  });
}

class GetProfileDetailsEvent extends ProfEvent{

}

class GetCountFriendEvent extends ProfEvent{

}


class GetBlockedUserEvent extends ProfEvent{

}

class GetCountriesUserEvent extends ProfEvent{

}

class UnBlockedUserEvent extends ProfEvent{

  int blockedId;
  UnBlockedUserEvent({
    required this.blockedId
  });
}

class UpdateUserInfoEvent extends ProfEvent{
 File? image;
 String? gender;
 String? name;
 String? personalStatus;
 String? birthDate;
 String?  online;
 CountryDataModel? country;
 UpdateUserInfoEvent({
   required this.image,
   required this.gender,
   required this.name,
   required this.country,
   required this.birthDate,
   required this.personalStatus,
   required this.online
});
}



class ChangePasswordEvent extends ProfEvent{
  String oldPassword;
  String password;
  String confirmPassword;
  ChangePasswordEvent({
    required this.oldPassword,
    required this.password,
    required this.confirmPassword
  });
}

class ResetParamEvent extends ProfEvent{

}

class SendCoinsEvent extends ProfEvent{
   String userReceivedId;
   String numberOfCoinsOrDiamond;
   String type;
   SendCoinsEvent({required this.type,
   required this.numberOfCoinsOrDiamond,
     required this.userReceivedId
   });
}