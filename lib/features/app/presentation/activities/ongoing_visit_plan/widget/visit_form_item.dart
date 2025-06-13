import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/entities/forms_response.dart';

Widget visitFormItem(
    {required FormList formItem,
    Function? deleteForm,
    Function? editForm,
    bool editable = false}) {
  return SizedBox(
    child: Column(
      children: [
        ...List.generate(
          formItem.visitForms!.length,
          (formsIndex) => Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ...List.generate(
                          formItem.visitForms![formsIndex]!.visitFormDetails!
                              .length,
                          (detailsIndex) {
                            final details = formItem.visitForms![formsIndex]!
                                .visitFormDetails![detailsIndex]!;
                            return items(
                                type: details.inputType!,
                                title: details.field!.name.toString(),
                                value: details.value.toString(),
                                groupId: details.groupName ?? '',
                                groupName: detailsIndex == 0 &&
                                        details.groupName != null
                                    ? details.groupName ?? ''
                                    : details.groupName != null &&
                                            formItem
                                                    .visitForms![formsIndex]!
                                                    .visitFormDetails![
                                                        detailsIndex - 1]
                                                    ?.groupName !=
                                                details.groupName
                                        ? details.groupName!
                                        : '');
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  if (editable)
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ActionButton(
                            icon: Icons.edit,
                            press: () {
                              editForm!(
                                  formItem,
                                  formItem
                                      .visitForms![formsIndex]!.visitFormId!);
                            },
                            borderColor: const Color(0XFFCED8FA),
                            bgColor: const Color(0XFFECF0FE),
                          ),
                          if (formItem.canDelete!)
                            ActionButton(
                              icon: Icons.delete_outline,
                              press: () {
                                deleteForm!(
                                  id: formItem
                                      .visitForms![formsIndex]!.visitFormId,
                                  formId: formItem.id,
                                );
                              },
                              borderColor: const Color(0XFFCED8FA),
                              bgColor: const Color(0XFFECF0FE),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
        Container(height: 10),
      ],
    ),
  );
}

Widget items(
    {required String type,
    required String title,
    required String value,
    required String groupId,
    required String groupName}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (groupName.isNotEmpty)
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: TextB(
              text: groupName,
              fontSize: 16,
              fontColor: bBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 180,
                child: Container(
                  padding: EdgeInsets.only(left: groupId.isNotEmpty ? 10 : 0),
                  child: Row(
                    children: [
                      if (groupId.isNotEmpty)
                        const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(Icons.circle, size: 8, color: bGray)),
                      Expanded(
                          child: TextB(
                              text: title,
                              fontColor: groupId.isNotEmpty ? bGray : null)),
                    ],
                  ),
                )),
            const SizedBox(width: 5),
            Flexible(
              child: type != InputType.image.name
                  ? TextB(
                      text: value,
                      fontColor: bBlack,
                    )
                  : Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        border: Border.all(color: bLightGray),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: NetworkImageB(imageUrl: value),
                    ),
            ),
          ],
        ),
      ],
    ),
  );
}
