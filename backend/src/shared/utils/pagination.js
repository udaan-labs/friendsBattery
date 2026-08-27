/**
 * Parse page/limit query into Prisma-friendly skip/take.
 * @param {object} query
 * @param {{ defaultPage?: number, defaultLimit?: number }} [opts]
 */
function parsePagination(query = {}, { defaultPage = 1, defaultLimit = 10 } = {}) {
  const page = Math.max(1, parseInt(query.page, 10) || defaultPage);
  const limit = Math.max(1, parseInt(query.limit, 10) || defaultLimit);
  return {
    page,
    limit,
    skip: (page - 1) * limit,
    take: limit,
  };
}

module.exports = { parsePagination };
