// SecurityGroups

resource "aws_security_group" "sg_id" {
  for_each    = var.security_groups
  name        = each.key
  description = each.value.description
  vpc_id      = var.vpc_id

tags = merge(
    var.tags,                    # ← tags globais do ambiente
    { Name = each.key },         # ← tag Name padrão com base na key
    each.value.tags              # ← tags específicas do SG
  )
 }

locals {
  ingress_rules = flatten([
    for sg_name, sg in var.security_groups : [
      for rule in sg.ingress_rules : {
        sg_name = sg_name
        rule    = rule
      }
    ]
  ])

  egress_rules = flatten([
    for sg_name, sg in var.security_groups : [
      for rule in sg.egress_rules : {
        sg_name = sg_name
        rule    = rule
      }
    ]
  ])
}

# Regras de Ingresso
resource "aws_security_group_rule" "ingress" {
  for_each = {
    for rule in local.ingress_rules :
    "${rule.sg_name}-ingress-${md5(jsonencode(rule.rule))}" => rule
  }

  type              = "ingress"
  security_group_id = aws_security_group.sg_id[each.value.sg_name].id
  from_port         = each.value.rule.from_port
  to_port           = each.value.rule.to_port
  protocol          = each.value.rule.protocol
  cidr_blocks       = lookup(each.value.rule, "cidr_blocks", [])
  ipv6_cidr_blocks  = lookup(each.value.rule, "ipv6_cidr_blocks", [])
  prefix_list_ids   = lookup(each.value.rule, "prefix_list_ids", [])
  self              = lookup(each.value.rule, "self", null)
  description       = lookup(each.value.rule, "description", null)

  source_security_group_id = (
    lookup(each.value.rule, "source_security_group_name", null) != null ?
    aws_security_group.sg_id[each.value.rule.source_security_group_name].id :
    null
  )
}

# Regras de Egresso
resource "aws_security_group_rule" "egress" {
  for_each = {
    for rule in local.egress_rules :
    "${rule.sg_name}-ingress-${md5(jsonencode(rule.rule))}" => rule
  }

  type              = "egress"
  security_group_id = aws_security_group.sg_id[each.value.sg_name].id
  from_port         = each.value.rule.from_port
  to_port           = each.value.rule.to_port
  protocol          = each.value.rule.protocol
  cidr_blocks       = lookup(each.value.rule, "cidr_blocks", [])
  ipv6_cidr_blocks  = lookup(each.value.rule, "ipv6_cidr_blocks", [])
  prefix_list_ids   = lookup(each.value.rule, "prefix_list_ids", [])
  self              = lookup(each.value.rule, "self", null)
  description       = lookup(each.value.rule, "description", null)

  source_security_group_id = (
    lookup(each.value.rule, "source_security_group_name", null) != null ?
    aws_security_group.sg_id[each.value.rule.source_security_group_name].id :
    null
  )
}
