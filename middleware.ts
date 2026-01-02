import NextAuth from "next-auth";
import authConfig from "@/auth.config";

const { auth } = NextAuth(authConfig);

export default auth((req) => {
  const { nextUrl } = req;
  const isLoggedIn = !!req.auth;
  const user = req.auth?.user;

  const isApiAuthRoute = nextUrl.pathname.startsWith("/api/auth");
  const isPublicRoute = ["/", "/login", "/register"].includes(nextUrl.pathname);
  const isOnboardingRoute = nextUrl.pathname.startsWith("/onboarding");

  if (isApiAuthRoute) return;

  if (isLoggedIn && (nextUrl.pathname === "/login" || nextUrl.pathname === "/register")) {
    return Response.redirect(new URL("/", nextUrl));
  }

  if (!isLoggedIn && !isPublicRoute) {
    return Response.redirect(new URL("/login", nextUrl));
  }

  if (isLoggedIn) {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const extendedUser = user as any;
    const isOnboarded = extendedUser?.isOnboarded;
    const role = extendedUser?.role;

    if (isOnboarded && isOnboardingRoute) {
      return Response.redirect(new URL("/", nextUrl));
    }

    if (!isOnboarded) {
      let correctOnboardingPath = "";
      if (role === "ORANGTUA") {
        correctOnboardingPath = "/onboarding/orangtua";
      } else if (role === "PENDAMPING") {
        correctOnboardingPath = "/onboarding/pendamping";
      }

      if (correctOnboardingPath) {
        if (nextUrl.pathname !== correctOnboardingPath) {
          return Response.redirect(new URL(correctOnboardingPath, nextUrl));
        }
      }
    }
  }

  return;
});

export const config = {
  matcher: ["/((?!.+\\.[\\w]+$|_next).*)", "/", "/(api|trpc)(.*)"],
};
