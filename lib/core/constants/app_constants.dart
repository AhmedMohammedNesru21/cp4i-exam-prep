/// Application-wide constants and the C1000-204 blueprint.
library;

class AppConstants {
  AppConstants._();

  static const appName = 'CP4I Architect Prep';
  static const certificationTitle =
      'IBM Certified Cloud Pak for Integration v16.1.0 Solution Architect – Professional';
  static const examCode = 'C1000-204';

  /// Learning mastery: every learning round has exactly this many questions
  /// and only a perfect score passes.
  static const roundSize = 5;

  /// Mock exam format (official benchmark; verify against current IBM information).
  static const examQuestionCount = 64;
  static const examPassMark = 43;
  static const examDuration = Duration(minutes: 90);

  /// A weak concept is considered recovered after this many consecutive correct answers.
  static const conceptRecoveryStreak = 3;

  static const bankIndexAsset = 'assets/questions/index.json';
  static const databaseName = 'cp4i_exam_prep';

  static const disclaimer =
      'Unofficial study aid. All questions are original practice questions written against '
      'IBM\'s published C1000-204 objectives. They are not actual exam questions, and this app is '
      'not affiliated with or endorsed by IBM.';
}

/// Static description of one exam domain.
class CategoryInfo {
  const CategoryInfo({
    required this.id,
    required this.name,
    required this.shortName,
    required this.description,
    required this.weight,
    required this.targetQuestions,
    required this.examQuestions,
    required this.sortOrder,
  });

  final String id;
  final String name;
  final String shortName;
  final String description;

  /// Percentage weight in the official blueprint.
  final int weight;
  final int targetQuestions;

  /// Number of questions drawn into a 64-question mock exam.
  final int examQuestions;
  final int sortOrder;
}

const List<CategoryInfo> kCategories = [
  CategoryInfo(
    id: 'ovr',
    name: 'Cloud Pak for Integration Overview',
    shortName: 'CP4I Overview',
    description:
        'CP4I architecture, capabilities, integration assemblies, declarative APIs, licensing, LTS vs CD, '
        'installation planning, upgrades, hybrid and agile integration, enterprise integration patterns.',
    weight: 17,
    targetQuestions: 102,
    examQuestions: 11,
    sortOrder: 1,
  ),
  CategoryInfo(
    id: 'cpa',
    name: 'Container Platform Architecture',
    shortName: 'Container Platform',
    description:
        'OpenShift and Kubernetes architecture, operators and OLM, namespaces, environment topology, '
        'air-gapped installs, registries, scheduling, resources and networking.',
    weight: 14,
    targetQuestions: 84,
    examQuestions: 9,
    sortOrder: 2,
  ),
  CategoryInfo(
    id: 'prd',
    name: 'Product Capabilities & Use Cases',
    shortName: 'Capabilities',
    description:
        'API Connect, DataPower, App Connect Enterprise, IBM MQ, Event Streams, Event Endpoint '
        'Management, Automation assets and choosing the right capability.',
    weight: 22,
    targetQuestions: 132,
    examQuestions: 14,
    sortOrder: 3,
  ),
  CategoryInfo(
    id: 'sto',
    name: 'Storage Considerations',
    shortName: 'Storage',
    description:
        'PVs, PVCs, storage classes, access modes, block vs file, storage performance, persistent data '
        'and backup storage.',
    weight: 6,
    targetQuestions: 36,
    examQuestions: 4,
    sortOrder: 4,
  ),
  CategoryInfo(
    id: 'scl',
    name: 'Scaling & Resiliency',
    shortName: 'Scaling & HA',
    description:
        'HA, DR, RTO/RPO, backup and restore with OADP, autoscaling, load balancing, multi-zone and '
        'multi-region design for MQ, Event Streams, API Connect, ACE and DataPower.',
    weight: 17,
    targetQuestions: 102,
    examQuestions: 11,
    sortOrder: 5,
  ),
  CategoryInfo(
    id: 'sec',
    name: 'Security',
    shortName: 'Security',
    description:
        'Authentication, authorization, RBAC, service accounts, secrets, certificates, TLS/mTLS, '
        'OAuth 2.0, JWT, LDAP, network policies, container and API security, audit logging.',
    weight: 13,
    targetQuestions: 78,
    examQuestions: 8,
    sortOrder: 6,
  ),
  CategoryInfo(
    id: 'obs',
    name: 'Observability',
    shortName: 'Observability',
    description:
        'Monitoring, logging, metrics, tracing, OpenTelemetry, API analytics, product-specific '
        'monitoring, alerting and troubleshooting.',
    weight: 11,
    targetQuestions: 66,
    examQuestions: 7,
    sortOrder: 7,
  ),
];

CategoryInfo categoryById(String id) => kCategories.firstWhere((c) => c.id == id);
