import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fund_app/model/mutualfund_viewmodel.dart';
import 'package:fund_app/redux/actions/funddetail_actions.dart';
import 'package:fund_app/redux/state/app_state.dart';
import 'package:fund_app/redux/state/mutualfund_state.dart';
import 'package:fund_app/screens/mutualfund/topfund.dart';
import 'package:search_page/search_page.dart';

class MutualFund extends StatelessWidget {
  MutualFund({required this.store, required this.viewModel});

  final store;
  MutualFundViewModel viewModel;

  initState() {
    viewModel.loadingList();
  }

  clickFund(fundClass) {

    store.dispatch(loadingFundAction(fundClass.finId));
    //viewModel.clickFund(fundClass.finId);
  }

  Aboss(context, people) => showSearch(
    context: context,
    delegate: SearchPage<FundClass>(
      onQueryUpdate: (text) => {},
      items: people,
      searchLabel: 'Search funding',
      suggestion: Center(
        child: Text('Filter funding'),
      ),
      failure: Center(
        child: Text('No funding found :('),
      ),
      filter: (FundClass) => [
        FundClass.finId,
        FundClass.thName,
        FundClass.shortCode,
      ],
      builder: (FundClass) => ListTile(
        title: Text(FundClass.shortCode),
        subtitle: Text(FundClass.thName),
        trailing: Text(FundClass.finId),
        onTap: () => clickFund(FundClass),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MutualFundViewModel>(
        converter: (store) => MutualFundViewModel.fromStore(store),
        onInitialBuild: initState(),
        builder: (BuildContext context, MutualFundViewModel viewModel) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text('Mutual Funding'),
                leading: Icon(Icons.monetization_on_outlined),
                actions: <Widget>[
                  IconButton(
                      onPressed: () {
                        Aboss(context, viewModel.payload_1);
                      },
                      icon: Icon(Icons.search))
                ],
              ),
              body: TopFund(store: store ,viewModel: viewModel)
          );
        });
  }
}


