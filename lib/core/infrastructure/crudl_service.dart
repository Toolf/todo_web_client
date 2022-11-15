import 'dart:convert';

import 'package:dio/dio.dart';

import 'endpoint.dart';
import 'pagination/pagination.dart';
import '../exception/validation_exception.dart';
import 'pagination/pagination_schema.dart';
import '../schema/basic_shema.dart';
import '../schema/schema.dart';
import '../schema/schema_base.dart';

class CrudlService<Entity, CreateEntity, UpdateEntity> {
  final Schema<Entity> entitySchema;
  final SchemaBase<UpdateEntity> entityUpdateSchema;
  final SchemaBase<CreateEntity> entityCreateSchema;

  final Dio httpClient;

  CrudlService({
    required this.httpClient,
    required this.entitySchema,
    required this.entityUpdateSchema,
    required this.entityCreateSchema,
  });

  CreateEndpoint<CreateEntity> get create =>
      CreateEndpoint(entityCreateSchema, httpClient);
  ReadEndpoint<Entity> get read => ReadEndpoint(entitySchema, httpClient);
  UpdateEndpoint<Entity, UpdateEntity> get update =>
      UpdateEndpoint(entitySchema, entityUpdateSchema, httpClient);
  DeleteEndpoint<Entity> get delete => DeleteEndpoint(entitySchema, httpClient);
  ListEndpoint<Entity> get list => ListEndpoint(entitySchema, httpClient);
}

class CreateEndpoint<CreateEntity> extends Endpoint<CreateEntity, int> {
  final SchemaBase<CreateEntity> param;
  final Dio httpClient;

  CreateEndpoint(this.param, this.httpClient);

  @override
  SchemaBase<CreateEntity>? get parameters => param;
  @override
  SchemaBase<int>? get returns => intSchema;

  @override
  Future<int> method(CreateEntity data) async {
    final res = await httpClient.post(
      "/",
      data: {
        "method": "${param.name}/create",
        "data": data,
      },
    );
    final entityId = jsonDecode(res.data) as int;
    return entityId;
  }

  @override
  void validate(CreateEntity data) {}
}

class ReadEndpoint<Entity> extends Endpoint<int, Entity> {
  final SchemaBase<Entity> entitySchema;
  final Dio httpClient;

  ReadEndpoint(this.entitySchema, this.httpClient);

  @override
  SchemaBase<int>? get parameters => intSchema;
  @override
  SchemaBase<Entity>? get returns => entitySchema;

  @override
  Future<Entity> method(int entityId) async {
    final res = await httpClient.post(
      "/",
      data: {
        "method": "${entitySchema.name.toLowerCase()}/read",
        "data": entityId,
      },
    );
    final resJson = jsonDecode(res.data);
    final entity = entitySchema.entityConstructor(resJson);
    return entity;
  }

  @override
  void validate(int entityId) {
    if (entityId < 0) {
      throw ValidationException("Entity id must be positive number");
    }
  }
}

class UpdateEndpoint<Entity, UpdateEntity>
    extends Endpoint<UpdateEntity, Entity> {
  final SchemaBase<Entity> entitySchema;
  final SchemaBase<UpdateEntity> param;
  final Dio httpClient;

  UpdateEndpoint(this.entitySchema, this.param, this.httpClient);

  @override
  SchemaBase<UpdateEntity>? get parameters => param;
  @override
  SchemaBase<Entity>? get returns => entitySchema;

  @override
  Future<Entity> method(UpdateEntity updateEntity) async {
    final res = await httpClient.post(
      "/",
      data: {
        "method": "${entitySchema.name.toLowerCase()}/update",
        "data": updateEntity,
      },
    );
    final resJson = jsonDecode(res.data);
    final entity = entitySchema.entityConstructor(resJson);
    return entity;
  }

  @override
  void validate(UpdateEntity updateEntity) {}
}

class DeleteEndpoint<Entity> extends Endpoint<int, Entity> {
  final SchemaBase<Entity> entitySchema;
  final Dio httpClient;

  DeleteEndpoint(this.entitySchema, this.httpClient);

  @override
  SchemaBase<int>? get parameters => intSchema;
  @override
  SchemaBase<Entity>? get returns => entitySchema;

  @override
  Future<Entity> method(int entityId) async {
    final res = await httpClient.post(
      "/",
      data: {
        "method": "${entitySchema.name.toLowerCase()}/delete",
        "data": entityId,
      },
    );
    final resJson = jsonDecode(res.data);
    final entity = entitySchema.entityConstructor(resJson);
    return entity;
  }

  @override
  void validate(int entityId) {
    if (entityId < 0) {
      throw ValidationException("Entity id must be positive number");
    }
  }
}

class ListEndpoint<Entity>
    extends Endpoint<PaginationRequest, PaginationResponce<Entity>> {
  final Schema<Entity> entitySchema;
  final Dio httpClient;

  ListEndpoint(this.entitySchema, this.httpClient);

  @override
  SchemaBase<PaginationRequest>? get parameters => paginationRequestSchema;
  @override
  SchemaBase<PaginationResponce<Entity>>? get returns =>
      PaginationResponceSchema(entitySchema);

  @override
  Future<PaginationResponce<Entity>> method(PaginationRequest request) async {
    final res = await httpClient.post(
      "/",
      data: {
        "method": "${entitySchema.name.toLowerCase().toLowerCase()}/list",
        "data": request,
      },
    );
    final resJson = jsonDecode(res.data);
    final entities =
        PaginationResponceSchema(entitySchema).entityConstructor(resJson);
    return entities;
  }

  @override
  void validate(PaginationRequest request) {}
}
