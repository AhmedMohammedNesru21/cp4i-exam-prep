import 'dart:convert';

import '../domain/question.dart';

/// Parses the compact question bank asset format into [Question] entities.
///
/// Each file: {"category": "ovr", "prefix": "OVR", "questions": [row, ...]}
/// Each row:  [subcategory, "K#", component, text, options, answer, explanation,
///             rationales, scenario, tip]
/// where K is F/S/T/D (style) and # is 1-4 (difficulty); answer is an int or a list.
class QuestionBankParser {
  QuestionBankParser();

  final Map<String, int> _counters = {};

  /// Files must be parsed in the order listed in index.json so IDs stay stable.
  List<Question> parseFile(String source) {
    final doc = jsonDecode(source) as Map<String, dynamic>;
    final category = doc['category'] as String;
    final prefix = doc['prefix'] as String;
    final rows = doc['questions'] as List<dynamic>;
    return [for (final row in rows) _parseRow(category, prefix, row as List<dynamic>)];
  }

  Question _parseRow(String category, String prefix, List<dynamic> r) {
    if (r.length != 10) throw FormatException('Row in $prefix has ${r.length} fields, expected 10');
    final n = (_counters[prefix] ?? 0) + 1;
    _counters[prefix] = n;
    final id = '$prefix-${n.toString().padLeft(3, '0')}';
    final kd = r[1] as String;
    final options = (r[4] as List<dynamic>).cast<String>();
    final answer = r[5];
    final correct = answer is List ? answer.cast<int>().toList() : <int>[answer as int];
    correct.sort();
    final rationales = (r[7] as List<dynamic>).cast<String>();
    final component = r[2] as String;

    final q = Question(
      id: id,
      categoryId: category,
      subcategory: r[0] as String,
      style: QuestionStyle.fromCode(kd[0]),
      difficulty: Difficulty.fromLevel(int.parse(kd.substring(1))),
      component: component,
      text: r[3] as String,
      options: options,
      correctAnswers: correct,
      explanation: r[6] as String,
      optionRationales: rationales,
      scenario: r[8] as String,
      examTip: r[9] as String,
      documentationReference: documentationFor(component),
      versionApplicability: versionFor(component),
    );
    _validate(q);
    return q;
  }

  void _validate(Question q) {
    if (q.options.length < 3 || q.options.any((o) => o.trim().isEmpty)) {
      throw FormatException('${q.id}: invalid options');
    }
    if (q.correctAnswers.isEmpty || q.correctAnswers.any((i) => i < 0 || i >= q.options.length)) {
      throw FormatException('${q.id}: invalid answer reference');
    }
    if (q.optionRationales.length != q.options.length) {
      throw FormatException('${q.id}: rationale count does not match options');
    }
    if (q.explanation.trim().isEmpty) throw FormatException('${q.id}: missing explanation');
  }

  /// Documentation entry points per component (the technical source of truth).
  static String documentationFor(String component) {
    const cp4i = 'https://www.ibm.com/docs/en/cloud-paks/cp-integration/16.1.0';
    const ocp = 'https://docs.redhat.com/en/documentation/openshift_container_platform/4.16';
    return switch (component) {
      'API Connect' => 'https://www.ibm.com/docs/en/api-connect/10.0.8',
      'DataPower Gateway' => 'https://www.ibm.com/docs/en/datapower-gateway/10.6',
      'App Connect Enterprise' || 'App Connect Designer' => 'https://www.ibm.com/docs/en/app-connect/12.0',
      'IBM MQ' => 'https://www.ibm.com/docs/en/ibm-mq/9.4',
      'Event Streams' => 'https://ibm.github.io/event-automation/es/',
      'Event Endpoint Management' => 'https://ibm.github.io/event-automation/eem/',
      'Event Processing' => 'https://ibm.github.io/event-automation/ep/',
      'Aspera HSTS' => 'https://www.ibm.com/docs/en/ahts',
      'IBM License Service' ||
      'Cloud Pak foundational services' =>
        'https://www.ibm.com/docs/en/cloud-paks/foundational-services',
      'Instana' => 'https://www.ibm.com/docs/en/instana-observability',
      'OpenTelemetry' => 'https://opentelemetry.io/docs/',
      'Kubernetes' => 'https://kubernetes.io/docs/concepts/',
      'Red Hat OpenShift' || 'Operator Lifecycle Manager' => ocp,
      'cert-manager' => '$ocp/html/security_and_compliance/cert-manager-operator-for-red-hat-openshift',
      'OpenShift API for Data Protection' => '$ocp/html/backup_and_restore/oadp-application-backup-and-restore',
      'Red Hat OpenShift Data Foundation' => 'https://docs.redhat.com/en/documentation/red_hat_openshift_data_foundation',
      'Red Hat Advanced Cluster Security' =>
        'https://docs.redhat.com/en/documentation/red_hat_advanced_cluster_security_for_kubernetes',
      _ => cp4i, // Cloud Pak for Integration, Platform UI, Integration assemblies, Automation assets
    };
  }

  /// Version context for each component as shipped with/used by CP4I 16.1.0.
  static String versionFor(String component) => switch (component) {
        'Kubernetes' || 'OpenTelemetry' => 'Vendor-neutral concept; applies to CP4I 16.1.0 deployments',
        'Red Hat OpenShift' ||
        'Operator Lifecycle Manager' ||
        'cert-manager' ||
        'OpenShift API for Data Protection' ||
        'Red Hat OpenShift Data Foundation' ||
        'Red Hat Advanced Cluster Security' =>
          'OpenShift versions supported by CP4I 16.1.0 (check the support matrix)',
        _ => 'CP4I 16.1.0 (LTS); verify version-specific details in the linked documentation',
      };
}
