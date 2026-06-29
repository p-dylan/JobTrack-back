import { ConflictException, Injectable, NotFoundException } from '@nestjs/common';
import { CreateRoleDto } from './dto/create-role.dto';
import { UpdateRoleDto } from './dto/update-role.dto';
import { PrismaService } from 'prisma/prisma.service';
import { role } from 'prisma/generated/prisma/client';

@Injectable()
export class RoleService {
  constructor(private readonly prisma: PrismaService) {}
  async create(dto: CreateRoleDto) {

    return this.prisma.role.create({data: dto});
  }

  findAll() {
    return `This action returns all role`;
  }

  async findOne(id: number): Promise<role> {
      const role = await this.prisma.role.findUnique({ where: { id } });
      if (!role) throw new NotFoundException(`role with id: ${id} not found`);
      return role;
    }

  update(id: number, updateRoleDto: UpdateRoleDto) {
    return `This action updates a #${id} role`;
  }

  async delete(id: number): Promise<role> {
    await this.findOne(id);
    const usersWithRole = await this.prisma.user.count({
      where: { role_id: id },
    });

    if (usersWithRole > 0) {
      throw new ConflictException(
        `Impossible de supprimer ce rôle : ${usersWithRole} utilisateur(s) l'utilisent encore`
      );
    }
    return this.prisma.role.delete({ where: { id }});
  }
}
