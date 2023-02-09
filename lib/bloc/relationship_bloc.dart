import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starwears/bloc/authentication_bloc.dart';
import 'package:starwears/models/relationship.dart';
import 'package:starwears/services/products_service.dart';

part 'relationship_event.dart';
part 'relationship_state.dart';

class RelationshipBloc extends Bloc<RelationshipEvent, RelationshipState> {
  ProductsService productsService = ProductsService();
  AuthenticationBloc authenticationBloc;
  RelationshipBloc({required this.authenticationBloc})
      : super(RelationshipInitial()) {
    on<GetRelationShip>((event, emit) async {
      print("bkhix");

       try {
      final currentId = authenticationBloc.userId;
      if (currentId != null) {
        Relationship relationship =
            await productsService.getRelationShip(event.productId, currentId);
       switch (relationship.state) {
          case "outbided":
            print("yes");
            emit(OutbiddedState(relationship: relationship));
            break;
          case "never":
            print("nev");

            emit(NeverState(relationship: relationship));
            break;
          case "already":
            print("yeales");

            emit(AlreadyState(relationship: relationship));
            break;
          case "won":
            print("won");

            emit(WonState(relationship: relationship));
            break;
         default:
            
       }
      } else {
        throw Exception("User not logged in");
      }
       } catch (e) {
     emit(RelationshipFailed(error: e.toString()));
      }
    });
  }
}
