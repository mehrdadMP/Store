import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/data/repo/comment_repository.dart';
import 'package:store/theme.dart';
import 'package:store/ui/Product%20details/comment/bloc/comment_list_bloc.dart';
import 'package:store/ui/Widgets/error_widget.dart';
import 'package:text_scroll/text_scroll.dart';

class CommentList extends StatelessWidget {
  final int productId;

  const CommentList({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentListBloc>(
      create: (context) {
        final bloc = CommentListBloc(
            repository: commentRepository, productId: productId);
        bloc.add(CommentListStarted());
        return bloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
        builder: (context, state) {
          if (state is CommentListSuccess) {
            return SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: state.comments.length,
                    (context, index) => Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: LightThemeColor.backgroundColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextScroll(
                                        textDirection: TextDirection.rtl,
                                        velocity: Velocity(
                                            pixelsPerSecond: Offset(15, 0)),
                                        pauseBetween: Duration(seconds: 5),
                                        intervalSpaces: 50,
                                        state.comments[index].title,
                                        textAlign: TextAlign.justify,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      state.comments[index].date,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  state.comments[index].content,
                                  textAlign: TextAlign.justify,
                                )
                              ],
                            ),
                          ),
                        )));
          } else if (state is CommentListLoading) {
            return SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CommentListError) {
            return SliverToBoxAdapter(
              child: AppErrorWidget(
                exception: state.exception,
                onPressed: () {
                  return BlocProvider.of<CommentListBloc>(context)
                      .add(CommentListStarted());
                },
              ),
            );
          } else {
            throw Exception('state is not supported!');
          }
        },
      ),
    );
  }
}
