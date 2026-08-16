const usersRepository = require('./users.repository');
const authRepository = require('../auth/auth.repository');
const orgEventsRepository = require('../../shared/org-events.repository');
const ROLES = require('../../shared/constants/roles');
const { httpError } = require('../../shared/utils/http-error');

const STAFF_ROLES = new Set([ROLES.ADMIN, ROLES.SELLER, ROLES.EMPLOYEE]);

function mapAccount(u) {
  return {
    id: Number(u.id),
    user_id: u.userId,
    user_name: u.userName,
    role: u.role,
    is_active: u.isActive,
    location: u.location ? { name: u.location.name } : null,
  };
}

class UsersService {
  async listAccounts(role) {
    const users = await usersRepository.findAccounts(role);
    return users.map(mapAccount);
  }

  async setActive(actor, id, isActive) {
    const user = await usersRepository.findById(id);
    if (!user) throw httpError(404, 'User not found');
    if (Number(user.id) === Number(actor.id)) {
      throw httpError(403, 'Cannot change your own account');
    }
    if (!STAFF_ROLES.has(user.role)) {
      throw httpError(403, 'Cannot change this account');
    }

    const updated = await usersRepository.setActive(id, isActive);

    if (isActive === false && user.role === ROLES.EMPLOYEE) {
      await authRepository.closeAllOpenEmployeeSessions(user.id);
    }

    await orgEventsRepository.create({
      action: isActive ? 'USER_ACTIVATED' : 'USER_DEACTIVATED',
      actorId: actor.id,
      entityType: 'USER',
      entityId: user.id,
      payload: { user_id: user.userId, role: user.role, is_active: isActive },
    });

    return {
      id: Number(updated.id),
      user_id: updated.userId,
      role: updated.role,
      is_active: updated.isActive,
    };
  }
}

module.exports = new UsersService();
