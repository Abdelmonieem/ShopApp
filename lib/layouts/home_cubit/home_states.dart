abstract class HomeStates {}
class HomeIntialState extends HomeStates{}
class HomeNaveBarChange extends HomeStates{}

class GetHomeDataLoading extends HomeStates{}
class GetHomeDataSuccess extends HomeStates{}
class GetHomeDataFailure extends HomeStates{}

class GetCategoriesDataLoading extends HomeStates{}
class GetCategoriesDataSuccess extends HomeStates{}
class GetCategoriesDataFailure extends HomeStates{}

class GetFavoritesDataLoading extends HomeStates{}
class GetFavoritesDataSuccess extends HomeStates{}
class GetFavoritesDataFailure extends HomeStates{}

class postFavoritesDataLoading extends HomeStates{}
class postFavoritesDataSuccess extends HomeStates{}
class postFavoritesDataFailure extends HomeStates{}

class postsearchLoading extends HomeStates{}
class postsearchSuccess extends HomeStates{}
class postsearchFailure extends HomeStates{}

class ChangeIconFav extends HomeStates{}

class AddItem extends HomeStates{}
class RemoveItem extends HomeStates{}
